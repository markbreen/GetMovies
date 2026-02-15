using NAudio.Wave;

namespace VoiceType;

/// <summary>
/// Records microphone audio to an in-memory WAV buffer using NAudio.
/// Optimised for speech: 16 kHz, 16-bit, mono.
/// </summary>
public class AudioRecorder : IDisposable
{
    private WaveInEvent? _waveIn;
    private MemoryStream? _audioStream;
    private WaveFileWriter? _waveWriter;

    public bool IsRecording { get; private set; }

    public void StartRecording()
    {
        if (IsRecording) return;

        _audioStream = new MemoryStream();

        _waveIn = new WaveInEvent
        {
            WaveFormat = new WaveFormat(sampleRate: 16000, bits: 16, channels: 1),
            BufferMilliseconds = 50
        };

        // Wrap in IgnoreDisposeStream so WaveFileWriter.Dispose() finalises the
        // WAV header without closing the underlying MemoryStream.
        _waveWriter = new WaveFileWriter(new IgnoreDisposeStream(_audioStream), _waveIn.WaveFormat);

        _waveIn.DataAvailable += (_, e) =>
        {
            _waveWriter?.Write(e.Buffer, 0, e.BytesRecorded);
        };

        _waveIn.StartRecording();
        IsRecording = true;
    }

    public byte[]? StopRecording()
    {
        if (!IsRecording) return null;
        IsRecording = false;

        _waveIn?.StopRecording();

        // Dispose writer first — this finalises the WAV header (RIFF sizes)
        // through the IgnoreDisposeStream, keeping _audioStream alive.
        _waveWriter?.Dispose();
        _waveWriter = null;

        var audioData = _audioStream?.ToArray();

        _waveIn?.Dispose();
        _waveIn = null;

        _audioStream?.Dispose();
        _audioStream = null;

        return audioData;
    }

    public void Dispose()
    {
        if (IsRecording) StopRecording();
        _waveIn?.Dispose();
        _waveWriter?.Dispose();
        _audioStream?.Dispose();
    }
}

/// <summary>
/// Stream wrapper that passes all operations through to the inner stream
/// but ignores Dispose calls. This allows WaveFileWriter to finalise its
/// WAV header without closing the MemoryStream we still need to read from.
/// </summary>
internal class IgnoreDisposeStream : Stream
{
    private readonly Stream _inner;

    public IgnoreDisposeStream(Stream inner) => _inner = inner;

    public override bool CanRead => _inner.CanRead;
    public override bool CanSeek => _inner.CanSeek;
    public override bool CanWrite => _inner.CanWrite;
    public override long Length => _inner.Length;
    public override long Position
    {
        get => _inner.Position;
        set => _inner.Position = value;
    }

    public override void Flush() => _inner.Flush();
    public override int Read(byte[] buffer, int offset, int count) => _inner.Read(buffer, offset, count);
    public override long Seek(long offset, SeekOrigin origin) => _inner.Seek(offset, origin);
    public override void SetLength(long value) => _inner.SetLength(value);
    public override void Write(byte[] buffer, int offset, int count) => _inner.Write(buffer, offset, count);

    protected override void Dispose(bool disposing)
    {
        // Intentionally do nothing — keep inner stream open.
    }
}
