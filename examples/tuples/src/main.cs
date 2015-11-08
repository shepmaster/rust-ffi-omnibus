using System;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
struct IntTuple {
    public uint x;
    public uint y;

    public static implicit operator Tuple<uint, uint>(IntTuple t)
    {
        return Tuple.Create(t.x, t.y);
    }

    public static implicit operator IntTuple(Tuple<uint, uint> t)
    {
        return new IntTuple { x = t.Item1, y = t.Item2 };
    }
};

class Tuples
{
    [DllImport("tuples")]
    private static extern IntTuple flip_things_around(IntTuple t);

    public static Tuple<uint, uint> FlipThingsAround(Tuple<uint, uint> t)
    {
        return flip_things_around(t);
    }

    static public void Main()
    {
        var tuple = Tuple.Create(10u, 20u);
        var newTuple = Tuples.FlipThingsAround(tuple);
        Console.WriteLine($"({newTuple.Item1},{newTuple.Item2})");
    }
}
