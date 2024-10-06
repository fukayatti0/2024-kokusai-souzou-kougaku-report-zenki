using System;

class Program
{
    static void Main()
    {
        const long iterations = 100000000;
        Console.WriteLine($"計算回数: {iterations:N0}");

        double result = 0.0;
        for (long i = 0; i < iterations; i++)
        {
            result += Math.Sin(i) * Math.Cos(i);
        }

        Console.WriteLine($"計算結果: {result}");
    }
}