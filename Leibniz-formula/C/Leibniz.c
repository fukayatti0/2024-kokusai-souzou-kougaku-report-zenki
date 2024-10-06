#include <stdio.h>
#include <math.h>


// ライプニッツ公式計算関数
double calculateLeibnizFormula(int terms) {
    double piApprox = 0.0;
    double sign = 1.0;
    for (int i = 0; i < terms; i++) {
        piApprox += sign / (2.0 * i + 1.0);
        sign = -sign;
    }
    return piApprox * 4.0;
}

int main() {
    // 計算する項数(1億回)
    const int n = 100000000;
    
    // ライプニッツ公式計算
    double piApprox = calculateLeibnizFormula(n);
    
    // 誤差計算
    double calculationError = M_PI - piApprox;
    
    printf("円周率近似値: %.15f\n", piApprox);
    printf("計算誤差   : %.15f\n", calculationError);
    
    return 0;
}