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
        get { return false; }
    }

    public string AsString()
    {
        int len = 0;
        while (Marshal.ReadByte(handle, len) != 0) { ++len; }
        byte[] buffer = new byte[len];
        Marshal.Copy(handle, buffer, 0, buffer.Length);
        return Encoding.UTF8.GetString(buffer);
    }

    protected override bool ReleaseHandle()
    {
        Native.theme_song_free(handle);
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
