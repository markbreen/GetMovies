namespace VoiceType;

static class Program
{
    [STAThread]
    static void Main()
    {
        // Prevent multiple instances
        using var mutex = new Mutex(true, "VoiceType_SingleInstance", out bool createdNew);
        if (!createdNew)
        {
            MessageBox.Show(
                "VoiceType is already running. Check the system tray.",
                "VoiceType",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information);
            return;
        }

        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);

        var config = AppConfig.Load();

        if (string.IsNullOrWhiteSpace(config.OpenAIApiKey))
        {
            MessageBox.Show(
                "Please set your OpenAI API key in config.json before running VoiceType.\n\n" +
                $"Config location: {Path.Combine(AppContext.BaseDirectory, "config.json")}",
                "VoiceType — Configuration Required",
                MessageBoxButtons.OK,
                MessageBoxIcon.Warning);
            return;
        }

        Application.Run(new VoiceTypeContext(config));
    }
}
