using System;
using System.Runtime.InteropServices;

class StringArguments
{
    [DllImport("string_arguments", EntryPoint="how_many_characters")]
    public static extern uint HowManyCharacters(string s);

    static public void Main()
    {
        var count = StringArguments.HowManyCharacters("göes to élevên");
        Console.WriteLine(count);
    }
}
