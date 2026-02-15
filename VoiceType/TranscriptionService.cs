using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace VoiceType;

/// <summary>
/// Handles OpenAI API calls: Whisper for transcription and GPT-4o for text cleanup.
/// </summary>
public class TranscriptionService : IDisposable
{
    private readonly HttpClient _httpClient;
    private readonly AppConfig _config;

    private const string WhisperEndpoint = "https://api.openai.com/v1/audio/transcriptions";
    private const string ChatEndpoint = "https://api.openai.com/v1/chat/completions";

    public TranscriptionService(AppConfig config)
    {
        _config = config;
        _httpClient = new HttpClient
        {
            Timeout = TimeSpan.FromSeconds(30)
        };
        _httpClient.DefaultRequestHeaders.Authorization =
            new AuthenticationHeaderValue("Bearer", config.OpenAIApiKey);
    }

    /// <summary>
    /// Send recorded WAV audio to the Whisper API and return the raw transcription.
    /// </summary>
    public async Task<string> TranscribeAsync(byte[] audioData)
    {
        using var content = new MultipartFormDataContent();

        var audioContent = new ByteArrayContent(audioData);
        audioContent.Headers.ContentType = new MediaTypeHeaderValue("audio/wav");

        content.Add(audioContent, "file", "recording.wav");
        content.Add(new StringContent(_config.WhisperModel), "model");
        content.Add(new StringContent("en"), "language");

        var response = await _httpClient.PostAsync(WhisperEndpoint, content);
        response.EnsureSuccessStatusCode();

        var json = await response.Content.ReadAsStringAsync();
        using var doc = JsonDocument.Parse(json);
        return doc.RootElement.GetProperty("text").GetString() ?? "";
    }

    /// <summary>
    /// Send raw transcription to GPT-4o for light grammar/punctuation cleanup.
    /// </summary>
    public async Task<string> CleanupTextAsync(string rawText)
    {
        var requestBody = new
        {
            model = _config.CleanupModel,
            messages = new object[]
            {
                new { role = "system", content = _config.CleanupPrompt },
                new { role = "user", content = rawText }
            },
            max_tokens = 2048,
            temperature = 0.3
        };

        var json = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

        var response = await _httpClient.PostAsync(ChatEndpoint, httpContent);
        response.EnsureSuccessStatusCode();

        var responseJson = await response.Content.ReadAsStringAsync();
        using var doc = JsonDocument.Parse(responseJson);

        return doc.RootElement
            .GetProperty("choices")[0]
            .GetProperty("message")
            .GetProperty("content")
            .GetString() ?? rawText;
    }

    public void Dispose()
    {
        _httpClient.Dispose();
    }
}
