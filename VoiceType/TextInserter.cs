using System.Runtime.InteropServices;

namespace VoiceType;

/// <summary>
/// Inserts text at the current cursor position using Win32 SendInput
/// with KEYEVENTF_UNICODE for full Unicode support.
/// </summary>
public class TextInserter
{
    private const uint INPUT_KEYBOARD = 1;
    private const uint KEYEVENTF_UNICODE = 0x0004;
    private const uint KEYEVENTF_KEYUP = 0x0002;

    [StructLayout(LayoutKind.Sequential)]
    private struct INPUT
    {
        public uint type;
        public INPUTUNION u;
    }

    [StructLayout(LayoutKind.Explicit)]
    private struct INPUTUNION
    {
        [FieldOffset(0)]
        public KEYBDINPUT ki;
    }

    [StructLayout(LayoutKind.Sequential)]
    private struct KEYBDINPUT
    {
        public ushort wVk;
        public ushort wScan;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    [DllImport("user32.dll", SetLastError = true)]
    private static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

    /// <summary>
    /// Simulates keyboard input to type the given text at the current cursor position.
    /// Each character is sent as a Unicode key-down/key-up pair.
    /// </summary>
    public void InsertText(string text)
    {
        if (string.IsNullOrEmpty(text)) return;

        // Brief pause so the target application is ready to receive input
        Thread.Sleep(100);

        var inputs = new List<INPUT>();

        foreach (char c in text)
        {
            // For surrogate pairs (emoji, etc.), each char in the pair is sent separately.
            // SendInput with KEYEVENTF_UNICODE handles this correctly on modern Windows.

            // Key down
            inputs.Add(new INPUT
            {
                type = INPUT_KEYBOARD,
                u = new INPUTUNION
                {
                    ki = new KEYBDINPUT
                    {
                        wVk = 0,
                        wScan = c,
                        dwFlags = KEYEVENTF_UNICODE,
                        time = 0,
                        dwExtraInfo = IntPtr.Zero
                    }
                }
            });

            // Key up
            inputs.Add(new INPUT
            {
                type = INPUT_KEYBOARD,
                u = new INPUTUNION
                {
                    ki = new KEYBDINPUT
                    {
                        wVk = 0,
                        wScan = c,
                        dwFlags = KEYEVENTF_UNICODE | KEYEVENTF_KEYUP,
                        time = 0,
                        dwExtraInfo = IntPtr.Zero
                    }
                }
            });
        }

        var inputArray = inputs.ToArray();
        SendInput((uint)inputArray.Length, inputArray, Marshal.SizeOf<INPUT>());
    }
}
