using System.Diagnostics;
using System.Runtime.InteropServices;

namespace VoiceType;

/// <summary>
/// Listens for global Ctrl+Alt press-and-hold using a low-level keyboard hook.
/// Raises RecordingStarted when both keys are held and RecordingStopped when released.
/// </summary>
public class HotkeyManager : IDisposable
{
    // Hook type
    private const int WH_KEYBOARD_LL = 13;

    // Key messages
    private const int WM_KEYDOWN = 0x0100;
    private const int WM_KEYUP = 0x0101;
    private const int WM_SYSKEYDOWN = 0x0104;
    private const int WM_SYSKEYUP = 0x0105;

    // Virtual key codes
    private const int VK_LCONTROL = 0xA2;
    private const int VK_RCONTROL = 0xA3;
    private const int VK_CONTROL = 0x11;
    private const int VK_LMENU = 0xA4;   // Left Alt
    private const int VK_RMENU = 0xA5;   // Right Alt
    private const int VK_MENU = 0x12;    // Alt

    private delegate IntPtr LowLevelKeyboardProc(int nCode, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll", SetLastError = true)]
    private static extern IntPtr SetWindowsHookEx(int idHook, LowLevelKeyboardProc lpfn,
        IntPtr hMod, uint dwThreadId);

    [DllImport("user32.dll", SetLastError = true)]
    private static extern bool UnhookWindowsHookEx(IntPtr hhk);

    [DllImport("user32.dll")]
    private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);

    [DllImport("kernel32.dll")]
    private static extern IntPtr GetModuleHandle(string? lpModuleName);

    private IntPtr _hookId = IntPtr.Zero;
    private LowLevelKeyboardProc? _hookProc;  // prevent GC of delegate
    private bool _ctrlDown;
    private bool _altDown;
    private bool _isRecording;
    private readonly SynchronizationContext? _syncContext;

    public event EventHandler? RecordingStarted;
    public event EventHandler? RecordingStopped;

    public HotkeyManager()
    {
        _syncContext = SynchronizationContext.Current;
    }

    public void Start()
    {
        _hookProc = HookCallback;
        using var process = Process.GetCurrentProcess();
        using var module = process.MainModule!;
        _hookId = SetWindowsHookEx(WH_KEYBOARD_LL, _hookProc,
            GetModuleHandle(module.ModuleName), 0);

        if (_hookId == IntPtr.Zero)
        {
            throw new InvalidOperationException(
                $"Failed to install keyboard hook. Error: {Marshal.GetLastWin32Error()}");
        }
    }

    public void Stop()
    {
        if (_hookId != IntPtr.Zero)
        {
            UnhookWindowsHookEx(_hookId);
            _hookId = IntPtr.Zero;
        }
    }

    private IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam)
    {
        if (nCode >= 0)
        {
            int vkCode = Marshal.ReadInt32(lParam);
            int msg = (int)wParam;

            bool isKeyDown = msg == WM_KEYDOWN || msg == WM_SYSKEYDOWN;
            bool isKeyUp = msg == WM_KEYUP || msg == WM_SYSKEYUP;

            bool isCtrl = vkCode is VK_LCONTROL or VK_RCONTROL or VK_CONTROL;
            bool isAlt = vkCode is VK_LMENU or VK_RMENU or VK_MENU;

            if (isCtrl)
            {
                _ctrlDown = isKeyDown;
            }

            if (isAlt)
            {
                _altDown = isKeyDown;
            }

            // Transition: both held → start recording
            if (_ctrlDown && _altDown && !_isRecording)
            {
                _isRecording = true;
                PostEvent(RecordingStarted);
            }
            // Transition: either released → stop recording
            else if (!(_ctrlDown && _altDown) && _isRecording)
            {
                _isRecording = false;
                PostEvent(RecordingStopped);
            }
        }

        return CallNextHookEx(_hookId, nCode, wParam, lParam);
    }

    private void PostEvent(EventHandler? handler)
    {
        if (handler == null) return;

        if (_syncContext != null)
            _syncContext.Post(_ => handler(this, EventArgs.Empty), null);
        else
            handler(this, EventArgs.Empty);
    }

    public void Dispose()
    {
        Stop();
    }
}
