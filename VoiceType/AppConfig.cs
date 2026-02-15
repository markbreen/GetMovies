using System.Text.Json;
using System.Text.Json.Serialization;

namespace VoiceType;

/// <summary>
/// Application configuration loaded from config.json alongside the executable.
/// </summary>
public class AppConfig
{
    [JsonPropertyName("openai_api_key")]
    public string OpenAIApiKey { get; set; } = "";

    [JsonPropertyName("hotkey")]
    public string Hotkey { get; set; } = "Ctrl+Alt";

    [JsonPropertyName("whisper_model")]
    public string WhisperModel { get; set; } = "whisper-1";

    [JsonPropertyName("cleanup_model")]
    public string CleanupModel { get; set; } = "gpt-4o";

    [JsonPropertyName("cleanup_prompt")]
    public string CleanupPrompt { get; set; } =
        "You are a text cleanup assistant. The user has dictated text via voice. " +
        "Clean it up with minimal changes: fix grammar, punctuation, and remove filler words " +
        "(um, uh, like, you know). Preserve the original meaning, tone, and intent. " +
        "Do not rewrite or restructure. Return only the cleaned text with no explanation.";

    [JsonPropertyName("audio_format")]
    public string AudioFormat { get; set; } = "wav";

    [JsonPropertyName("skip_cleanup")]
    public bool SkipCleanup { get; set; } = false;

    private static readonly JsonSerializerOptions SerializerOptions = new()
    {
        WriteIndented = true
    };

    private static string ConfigPath =>
        Path.Combine(AppContext.BaseDirectory, "config.json");

    public static AppConfig Load()
    {
        if (!File.Exists(ConfigPath))
        {
            var defaults = new AppConfig();
            var json = JsonSerializer.Serialize(defaults, SerializerOptions);
            File.WriteAllText(ConfigPath, json);
            return defaults;
        }

        var configJson = File.ReadAllText(ConfigPath);
        return JsonSerializer.Deserialize<AppConfig>(configJson, SerializerOptions)
               ?? new AppConfig();
    }
}
