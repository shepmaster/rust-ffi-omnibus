using System;
using System.Runtime.InteropServices;

class SliceArguments
{
    [DllImport("slice_arguments")]
    private static extern uint sum_of_even(int[] n, UIntPtr len);

    public static uint SumOfEven(int[] n)
    {
        return sum_of_even(n, (UIntPtr)n.Length);
    }

    static public void Main()
    {
        var sum = SliceArguments.SumOfEven(new [] {1,2,3,4,5,6});
        Console.WriteLine(sum);
    }
}
