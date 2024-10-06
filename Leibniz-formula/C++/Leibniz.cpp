#include <iostream>
#include <chrono>
#include <cmath>
#include <iomanip>


// ライプニッツ公式計算
double CalculateLeibniz(int n) {
    double pi_approx = 0.0;
    double sign = 1;
    for (int i = 0; i < n; i++) {
        pi_approx += sign / (2.0 * i + 1.0);
        sign = -sign;
    }
    pi_approx *= 4.0;
    return pi_approx;
}


int main() {
    // 計算する項数(1億回)
    const int n = 100000000;

    // ライプニッツ公式計算
    const double pi_approx = CalculateLeibniz(n);

    // 誤差
    const double calculation_error = fabs(M_PI - pi_approx);

    std::cout << "円周率近似値  : " << pi_approx << std::endl;
    std::cout << "計算誤差      : " << calculation_error << std::endl;

    return 0;
}