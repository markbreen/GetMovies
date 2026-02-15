import Foundation

/// Application configuration loaded from ~/.voicetype/config.json.
/// Creates a default config file on first run.
struct AppConfig: Codable {
    var openAIApiKey: String
    var hotkey: String
    var whisperModel: String
    var cleanupModel: String
    var cleanupPrompt: String
    var audioFormat: String
    var skipCleanup: Bool

    enum CodingKeys: String, CodingKey {
        case openAIApiKey = "openai_api_key"
        case hotkey
        case whisperModel = "whisper_model"
        case cleanupModel = "cleanup_model"
        case cleanupPrompt = "cleanup_prompt"
        case audioFormat = "audio_format"
        case skipCleanup = "skip_cleanup"
    }

    static let `default` = AppConfig(
        openAIApiKey: "",
        hotkey: "Ctrl+Option",
        whisperModel: "whisper-1",
        cleanupModel: "gpt-4o",
        cleanupPrompt: "You are a text cleanup assistant. The user has dictated text via voice. "
            + "Clean it up with minimal changes: fix grammar, punctuation, and remove filler words "
            + "(um, uh, like, you know). Preserve the original meaning, tone, and intent. "
            + "Do not rewrite or restructure. Return only the cleaned text with no explanation.",
        audioFormat: "wav",
        skipCleanup: false
    )

    // ── File paths ──────────────────────────────────────────────────

    private static var configDirectory: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".voicetype")
    }

    private static var configPath: URL {
        configDirectory.appendingPathComponent("config.json")
    }

    // ── Load / save ─────────────────────────────────────────────────

    static func load() -> AppConfig {
        let path = configPath
        let fm = FileManager.default

        if !fm.fileExists(atPath: path.path) {
            // Create directory and write default config
            try? fm.createDirectory(at: configDirectory, withIntermediateDirectories: true)
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            if let data = try? encoder.encode(AppConfig.default) {
                try? data.write(to: path)
            }
            return .default
        }

        guard let data = try? Data(contentsOf: path),
              let config = try? JSONDecoder().decode(AppConfig.self, from: data) else {
            return .default
        }

        return config
    }
}
