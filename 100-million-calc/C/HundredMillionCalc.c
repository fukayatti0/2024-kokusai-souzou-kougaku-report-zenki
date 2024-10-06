#include <stdio.h>
#include <math.h>

int main() {
    const long long iterations = 100000000;
    printf("計算回数: %lld\n", iterations);
    
    
    double result = 0.0;
    for (long long i = 0; i < iterations; i++) {
        result += sin((double)i) * cos((double)i);
    }
    
    printf("計算結果: %f\n", result);
    
    return 0;
}