import AVFoundation
import Foundation

/// Records microphone audio to a temporary WAV file using AVAudioRecorder.
/// Output: 16 kHz, 16-bit, mono — optimised for speech / Whisper API.
class AudioRecorder {
    private var recorder: AVAudioRecorder?
    private var tempURL: URL?

    private(set) var isRecording = false

    /// Audio format matching the Windows version: 16 kHz, 16-bit PCM, mono.
    private let recordSettings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVSampleRateKey: 16000,
        AVNumberOfChannelsKey: 1,
        AVLinearPCMBitDepthKey: 16,
        AVLinearPCMIsFloatKey: false,
        AVLinearPCMIsBigEndianKey: false
    ]

    // ── Permission check ────────────────────────────────────────────

    /// Request microphone access. macOS will prompt the user on first call.
    func requestPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        default:
            completion(false)
        }
    }

    // ── Recording ───────────────────────────────────────────────────

    func startRecording() {
        guard !isRecording else { return }

        // Create a temporary file for the WAV output
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("wav")
        tempURL = url

        do {
            recorder = try AVAudioRecorder(url: url, settings: recordSettings)
            recorder?.record()
            isRecording = true
        } catch {
            print("VoiceType: Failed to start recording — \(error.localizedDescription)")
        }
    }

    /// Stops recording and returns the WAV audio data (or nil on failure).
    func stopRecording() -> Data? {
        guard isRecording, let recorder = recorder, let url = tempURL else { return nil }
        isRecording = false

        recorder.stop()
        self.recorder = nil

        defer {
            // Clean up temporary file
            try? FileManager.default.removeItem(at: url)
            tempURL = nil
        }

        return try? Data(contentsOf: url)
    }
}
