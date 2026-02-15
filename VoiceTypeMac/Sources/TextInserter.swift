import Cocoa
import CoreGraphics

/// Inserts text at the current cursor position by:
///   1. Saving the current clipboard contents
///   2. Placing our text on the clipboard
///   3. Simulating ⌘V (paste)
///   4. Restoring the original clipboard
///
/// This clipboard-based approach is the most reliable method on macOS — it's
/// the same technique used by TextExpander, Alfred, and similar tools.
/// Direct CGEvent keystroke simulation doesn't handle Unicode reliably.
class TextInserter {
    // Virtual key code for 'V' on a Mac keyboard
    private static let kVK_V: CGKeyCode = 0x09

    func insertText(_ text: String) {
        guard !text.isEmpty else { return }

        let pasteboard = NSPasteboard.general

        // ── 1. Save current clipboard ───────────────────────────────
        let savedItems = backup(pasteboard: pasteboard)

        // ── 2. Put our text on the clipboard ────────────────────────
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)

        // Brief pause for the pasteboard change to propagate
        usleep(50_000) // 50 ms

        // ── 3. Simulate ⌘V ─────────────────────────────────────────
        simulatePaste()

        // Brief pause to let the paste complete in the target app
        usleep(100_000) // 100 ms

        // ── 4. Restore original clipboard ───────────────────────────
        restore(pasteboard: pasteboard, items: savedItems)
    }

    // ── Clipboard backup/restore ────────────────────────────────────

    private func backup(pasteboard: NSPasteboard) -> [(NSPasteboard.PasteboardType, Data)] {
        var items: [(NSPasteboard.PasteboardType, Data)] = []
        for type in pasteboard.types ?? [] {
            if let data = pasteboard.data(forType: type) {
                items.append((type, data))
            }
        }
        return items
    }

    private func restore(pasteboard: NSPasteboard,
                         items: [(NSPasteboard.PasteboardType, Data)]) {
        pasteboard.clearContents()
        for (type, data) in items {
            pasteboard.setData(data, forType: type)
        }
    }

    // ── Simulate ⌘V via CGEvent ─────────────────────────────────────

    private func simulatePaste() {
        let source = CGEventSource(stateID: .hidSystemState)

        // ⌘ down + V down
        guard let keyDown = CGEvent(keyboardEventSource: source,
                                    virtualKey: Self.kVK_V,
                                    keyDown: true) else { return }
        keyDown.flags = .maskCommand

        // ⌘ down + V up
        guard let keyUp = CGEvent(keyboardEventSource: source,
                                  virtualKey: Self.kVK_V,
                                  keyDown: false) else { return }
        keyUp.flags = .maskCommand

        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }
}
