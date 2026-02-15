import Cocoa

/// Monitors global keyboard events for Control+Option press-and-hold.
/// On Mac, the Windows "Alt" key maps to "Option" (⌥).
///
/// Requires Accessibility permission:
///   System Settings > Privacy & Security > Accessibility > VoiceType
class HotkeyManager {
    var onRecordingStarted: (() -> Void)?
    var onRecordingStopped: (() -> Void)?

    private var globalMonitor: Any?
    private var localMonitor: Any?
    private var isRecording = false

    func start() {
        // Global monitor — fires when another app is in focus
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            self?.handleFlagsChanged(event)
        }

        // Local monitor — fires when VoiceType itself is in focus
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            self?.handleFlagsChanged(event)
            return event
        }
    }

    func stop() {
        if let monitor = globalMonitor {
            NSEvent.removeMonitor(monitor)
            globalMonitor = nil
        }
        if let monitor = localMonitor {
            NSEvent.removeMonitor(monitor)
            localMonitor = nil
        }
    }

    private func handleFlagsChanged(_ event: NSEvent) {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        let controlDown = flags.contains(.control)
        let optionDown = flags.contains(.option)

        if controlDown && optionDown && !isRecording {
            isRecording = true
            onRecordingStarted?()
        } else if !(controlDown && optionDown) && isRecording {
            isRecording = false
            onRecordingStopped?()
        }
    }

    deinit {
        stop()
    }
}
