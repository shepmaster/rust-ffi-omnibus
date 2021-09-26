using System;
using System.Runtime.InteropServices;
using System.Text;

internal class Native
{
    [DllImport("string_return")]
    internal static extern ThemeSongHandle theme_song_generate(byte length);
    [DllImport("string_return")]
    internal static extern void theme_song_free(IntPtr song);
}

internal class ThemeSongHandle : SafeHandle
{
    public ThemeSongHandle() : base(IntPtr.Zero, true) {}

    public override bool IsInvalid
    {
        get { return this.handle == IntPtr.Zero; }
    }

    public string AsString()
    {
        return Marshal.PtrToStringUTF8(handle);
    }

    protected override bool ReleaseHandle()
    {
        if (!this.IsInvalid)
        {
            Native.theme_song_free(handle);
        }

        return true;
    }
}

public class ThemeSong : IDisposable
{
    private ThemeSongHandle song;
    private string songString;

    public ThemeSong(byte length)
    {
        song = Native.theme_song_generate(length);
    }

    public override string ToString()
    {
        if (songString == null) {
            songString = song.AsString();
        }
        return songString;
    }

    public void Dispose()
    {
        song.Dispose();
    }

    static public void Main()
    {
        var song = new ThemeSong(5);
        Console.WriteLine("{0}", song);
    }
}
