import Foundation

/// Handles OpenAI API calls: Whisper for transcription and GPT-4o for text cleanup.
class TranscriptionService {
    private let config: AppConfig

    private let whisperURL = URL(string: "https://api.openai.com/v1/audio/transcriptions")!
    private let chatURL    = URL(string: "https://api.openai.com/v1/chat/completions")!

    init(config: AppConfig) {
        self.config = config
    }

    // ── Whisper transcription ───────────────────────────────────────

    /// Send recorded WAV audio to the Whisper API and return the raw transcription.
    func transcribe(audioData: Data) async throws -> String {
        let boundary = UUID().uuidString

        var request = URLRequest(url: whisperURL)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("Bearer \(config.openAIApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.appendMultipart(boundary: boundary, name: "file", filename: "recording.wav",
                             contentType: "audio/wav", data: audioData)
        body.appendMultipart(boundary: boundary, name: "model", value: config.whisperModel)
        body.appendMultipart(boundary: boundary, name: "language", value: "en")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)
        try validateResponse(response, data: data)

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        return json?["text"] as? String ?? ""
    }

    // ── GPT-4o text cleanup ─────────────────────────────────────────

    /// Send raw transcription to GPT-4o for light grammar/punctuation cleanup.
    func cleanupText(_ text: String) async throws -> String {
        var request = URLRequest(url: chatURL)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("Bearer \(config.openAIApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": config.cleanupModel,
            "messages": [
                ["role": "system", "content": config.cleanupPrompt],
                ["role": "user",   "content": text]
            ],
            "max_tokens": 2048,
            "temperature": 0.3
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        try validateResponse(response, data: data)

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let choices = json?["choices"] as? [[String: Any]]
        let message = choices?.first?["message"] as? [String: Any]
        return message?["content"] as? String ?? text
    }

    // ── Helpers ─────────────────────────────────────────────────────

    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200...299).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? "(no body)"
            throw VoiceTypeError.apiError(statusCode: http.statusCode, message: body)
        }
    }
}

// ── Error type ──────────────────────────────────────────────────────

enum VoiceTypeError: LocalizedError {
    case apiError(statusCode: Int, message: String)

    var errorDescription: String? {
        switch self {
        case .apiError(let code, let msg):
            return "OpenAI API error (\(code)): \(msg)"
        }
    }
}

// ── Data helpers for multipart form encoding ────────────────────────

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }

    mutating func appendMultipart(boundary: String, name: String, value: String) {
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
        append("\(value)\r\n")
    }

    mutating func appendMultipart(boundary: String, name: String, filename: String,
                                  contentType: String, data: Data) {
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        append("Content-Type: \(contentType)\r\n\r\n")
        append(data)
        append("\r\n")
    }
}
