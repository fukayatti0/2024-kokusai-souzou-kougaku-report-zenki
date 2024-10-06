#include <iostream>
#include <chrono>
#include <iomanip>
#include <cmath>

int main() {
    // 計算回数
    const long long ITERATIONS = 100000000;  // 1億回の繰り返し
    
    std::cout << "計算回数: " << ITERATIONS << std::endl;
    
    // 開始時間を記録
    auto start = std::chrono::high_resolution_clock::now();
    
    // Pythonと同じ計算
    double result = 0.0;
    for (long long i = 0; i < ITERATIONS; ++i) {
        result += std::sin(i) * std::cos(i);
    }
    
    std::cout << "計算結果: " << result << std::endl;
    
    return 0;
}