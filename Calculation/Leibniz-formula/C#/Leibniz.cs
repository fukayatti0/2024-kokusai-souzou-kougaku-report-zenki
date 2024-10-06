using System;

class Program
{
    // ライプニッツ公式計算
    static double CalculateLeibnizFormula(int terms)
    {
        double piApprox = 0.0;
        double sign = 1.0;
        for (int i = 0; i < terms; i++)
        {
            piApprox += sign / (2.0 * i + 1.0);
            sign = -sign;
        }
        piApprox *= 4.0;
        return piApprox;
    }

    static void Main()
    {
        // 計算する項数(1億回)
        const int n = 100000000;

        // ライプニッツ公式計算
        double piApprox = CalculateLeibnizFormula(n);

        // 誤差
        double calculationError = Math.PI - piApprox;

        Console.WriteLine("円周率近似値  : {0}", piApprox);
        Console.WriteLine("計算誤差{0}   : {0}", calculationError);
    }
}