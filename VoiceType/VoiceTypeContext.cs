using System.Drawing;
using System.Drawing.Drawing2D;

namespace VoiceType;

/// <summary>
/// Main application context — runs as a system tray app and orchestrates the
/// full voice-to-text pipeline: hotkey → record → transcribe → cleanup → insert.
/// </summary>
public class VoiceTypeContext : ApplicationContext
{
    private readonly NotifyIcon _trayIcon;
    private readonly HotkeyManager _hotkeyManager;
    private readonly AudioRecorder _audioRecorder;
    private readonly TranscriptionService _transcriptionService;
    private readonly TextInserter _textInserter;
    private readonly AppConfig _config;
    private bool _isProcessing;

    public VoiceTypeContext(AppConfig config)
    {
        _config = config;

        _trayIcon = new NotifyIcon
        {
            Icon = CreateIcon(Color.Gray),
            Text = "VoiceType — Ready",
            Visible = true,
            ContextMenuStrip = BuildContextMenu()
        };

        _audioRecorder = new AudioRecorder();
        _transcriptionService = new TranscriptionService(config);
        _textInserter = new TextInserter();

        _hotkeyManager = new HotkeyManager();
        _hotkeyManager.RecordingStarted += OnRecordingStarted;
        _hotkeyManager.RecordingStopped += OnRecordingStopped;
        _hotkeyManager.Start();

        _trayIcon.ShowBalloonTip(
            2000,
            "VoiceType",
            $"Ready. Hold {config.Hotkey} to dictate.",
            ToolTipIcon.Info);
    }

    // ── Context menu ────────────────────────────────────────────────

    private ContextMenuStrip BuildContextMenu()
    {
        var menu = new ContextMenuStrip();

        menu.Items.Add("About VoiceType", null, (_, _) =>
            MessageBox.Show(
                "VoiceType v1.0\n" +
                "Voice-to-text for Windows\n" +
                "Phase 1 — Proof of Concept\n\n" +
                "Hold Ctrl+Alt to dictate.\n" +
                "Uses OpenAI Whisper + GPT-4o.",
                "About VoiceType",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information));

        menu.Items.Add(new ToolStripSeparator());
        menu.Items.Add("Exit", null, (_, _) => Shutdown());

        return menu;
    }

    // ── Recording events ────────────────────────────────────────────

    private void OnRecordingStarted(object? sender, EventArgs e)
    {
        if (_isProcessing) return;

        _trayIcon.Icon = CreateIcon(Color.Red);
        _trayIcon.Text = "VoiceType — Recording...";
        _audioRecorder.StartRecording();
    }

    private async void OnRecordingStopped(object? sender, EventArgs e)
    {
        if (_isProcessing || !_audioRecorder.IsRecording) return;
        _isProcessing = true;

        try
        {
            // ── Stop recording ──────────────────────────────────────
            _trayIcon.Icon = CreateIcon(Color.Orange);
            _trayIcon.Text = "VoiceType — Processing...";

            var audioData = _audioRecorder.StopRecording();
            if (audioData is null || audioData.Length == 0)
            {
                _trayIcon.Text = "VoiceType — No audio captured";
                return;
            }

            // ── Transcribe with Whisper ─────────────────────────────
            var rawText = await _transcriptionService.TranscribeAsync(audioData);
            if (string.IsNullOrWhiteSpace(rawText))
            {
                _trayIcon.Text = "VoiceType — No speech detected";
                return;
            }

            // ── Cleanup with GPT-4o (optional) ─────────────────────
            string finalText;
            if (_config.SkipCleanup)
            {
                finalText = rawText;
            }
            else
            {
                finalText = await _transcriptionService.CleanupTextAsync(rawText);
            }

            // ── Insert at cursor ────────────────────────────────────
            _textInserter.InsertText(finalText);

            _trayIcon.Text = "VoiceType — Ready";
        }
        catch (HttpRequestException ex)
        {
            _trayIcon.ShowBalloonTip(
                3000, "VoiceType — API Error",
                $"OpenAI request failed: {ex.Message}",
                ToolTipIcon.Error);
            _trayIcon.Text = "VoiceType — API error";
        }
        catch (Exception ex)
        {
            _trayIcon.ShowBalloonTip(
                3000, "VoiceType — Error",
                ex.Message,
                ToolTipIcon.Error);
            _trayIcon.Text = "VoiceType — Error";
        }
        finally
        {
            _trayIcon.Icon = CreateIcon(Color.Gray);
            _isProcessing = false;
        }
    }

    // ── Tray icon generator ─────────────────────────────────────────

    private static Icon CreateIcon(Color color)
    {
        var bmp = new Bitmap(16, 16);
        using var g = Graphics.FromImage(bmp);

        g.SmoothingMode = SmoothingMode.AntiAlias;

        // Filled circle in the state colour
        using var brush = new SolidBrush(color);
        g.FillEllipse(brush, 1, 1, 14, 14);

        // "V" for VoiceType
        using var pen = new Pen(Color.White, 1.5f);
        g.DrawLine(pen, 4, 5, 8, 11);
        g.DrawLine(pen, 8, 11, 12, 5);

        return Icon.FromHandle(bmp.GetHicon());
    }

    // ── Shutdown ────────────────────────────────────────────────────

    private void Shutdown()
    {
        _hotkeyManager.Stop();
        _hotkeyManager.Dispose();
        _audioRecorder.Dispose();
        _transcriptionService.Dispose();
        _trayIcon.Visible = false;
        _trayIcon.Dispose();
        Application.Exit();
    }

    protected override void Dispose(bool disposing)
    {
        if (disposing) Shutdown();
        base.Dispose(disposing);
    }
}
