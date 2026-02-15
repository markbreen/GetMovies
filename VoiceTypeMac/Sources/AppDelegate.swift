import Cocoa

/// Main application delegate — runs as a menu bar app and orchestrates the
/// full voice-to-text pipeline: hotkey → record → transcribe → cleanup → insert.
class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private let hotkeyManager = HotkeyManager()
    private let audioRecorder = AudioRecorder()
    private var transcriptionService: TranscriptionService!
    private let textInserter = TextInserter()
    private var config: AppConfig!
    private var isProcessing = false

    // ── App lifecycle ───────────────────────────────────────────────

    func applicationDidFinishLaunching(_ notification: Notification) {
        config = AppConfig.load()

        guard !config.openAIApiKey.isEmpty else {
            let alert = NSAlert()
            alert.messageText = "Configuration Required"
            alert.informativeText = """
                Please set your OpenAI API key in:
                ~/.voicetype/config.json

                A default config file has been created for you.
                """
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            NSApp.terminate(nil)
            return
        }

        transcriptionService = TranscriptionService(config: config)

        setupStatusItem()
        setupHotkey()
        requestMicrophonePermission()
    }

    // ── Menu bar ────────────────────────────────────────────────────

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        updateStatusIcon(.ready)

        let menu = NSMenu()
        menu.addItem(withTitle: "About VoiceType", action: #selector(showAbout), keyEquivalent: "")
        menu.addItem(.separator())
        menu.addItem(withTitle: "Quit VoiceType", action: #selector(quit), keyEquivalent: "q")
        statusItem.menu = menu
    }

    @objc private func showAbout() {
        let alert = NSAlert()
        alert.messageText = "VoiceType v1.0"
        alert.informativeText = """
            Voice-to-text for macOS
            Phase 1 — Proof of Concept

            Hold Control+Option (⌃⌥) to dictate.
            Uses OpenAI Whisper + GPT-4o.
            """
        alert.alertStyle = .informational
        alert.runModal()
    }

    @objc private func quit() {
        hotkeyManager.stop()
        NSApp.terminate(nil)
    }

    // ── Hotkey ──────────────────────────────────────────────────────

    private func setupHotkey() {
        hotkeyManager.onRecordingStarted = { [weak self] in
            self?.startRecording()
        }
        hotkeyManager.onRecordingStopped = { [weak self] in
            self?.stopRecordingAndProcess()
        }
        hotkeyManager.start()
    }

    // ── Microphone permission ───────────────────────────────────────

    private func requestMicrophonePermission() {
        audioRecorder.requestPermission { [weak self] granted in
            if !granted {
                let alert = NSAlert()
                alert.messageText = "Microphone Access Required"
                alert.informativeText = """
                    VoiceType needs microphone access to record your voice.
                    Please grant permission in:
                    System Settings > Privacy & Security > Microphone
                    """
                alert.alertStyle = .warning
                alert.runModal()
                self?.quit()
            }
        }
    }

    // ── Recording pipeline ──────────────────────────────────────────

    private func startRecording() {
        guard !isProcessing else { return }
        updateStatusIcon(.recording)
        audioRecorder.startRecording()
    }

    private func stopRecordingAndProcess() {
        guard !isProcessing, audioRecorder.isRecording else { return }
        isProcessing = true
        updateStatusIcon(.processing)

        guard let audioData = audioRecorder.stopRecording(), !audioData.isEmpty else {
            isProcessing = false
            updateStatusIcon(.ready)
            return
        }

        Task {
            do {
                // Transcribe with Whisper
                let rawText = try await transcriptionService.transcribe(audioData: audioData)

                guard !rawText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    await MainActor.run {
                        isProcessing = false
                        updateStatusIcon(.ready)
                    }
                    return
                }

                // Cleanup with GPT-4o (optional)
                let finalText: String
                if config.skipCleanup {
                    finalText = rawText
                } else {
                    finalText = try await transcriptionService.cleanupText(rawText)
                }

                // Insert at cursor
                await MainActor.run {
                    textInserter.insertText(finalText)
                    isProcessing = false
                    updateStatusIcon(.ready)
                }
            } catch {
                await MainActor.run {
                    showError(error.localizedDescription)
                    isProcessing = false
                    updateStatusIcon(.ready)
                }
            }
        }
    }

    private func showError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "VoiceType Error"
        alert.informativeText = message
        alert.alertStyle = .critical
        alert.runModal()
    }

    // ── Status icon ─────────────────────────────────────────────────

    private enum AppState {
        case ready, recording, processing
    }

    private func updateStatusIcon(_ state: AppState) {
        guard let button = statusItem.button else { return }

        let size = NSSize(width: 18, height: 18)
        let image = NSImage(size: size, flipped: false) { rect in
            let color: NSColor
            switch state {
            case .ready:      color = .systemGray
            case .recording:  color = .systemRed
            case .processing: color = .systemOrange
            }

            // Filled circle
            color.setFill()
            NSBezierPath(ovalIn: rect.insetBy(dx: 2, dy: 2)).fill()

            // "V" in white
            let path = NSBezierPath()
            path.lineWidth = 1.5
            NSColor.white.setStroke()
            path.move(to: NSPoint(x: 5, y: 13))
            path.line(to: NSPoint(x: 9, y: 6))
            path.line(to: NSPoint(x: 13, y: 13))
            path.stroke()

            return true
        }

        button.image = image

        switch state {
        case .ready:      button.toolTip = "VoiceType — Ready"
        case .recording:  button.toolTip = "VoiceType — Recording..."
        case .processing: button.toolTip = "VoiceType — Processing..."
        }
    }
}
