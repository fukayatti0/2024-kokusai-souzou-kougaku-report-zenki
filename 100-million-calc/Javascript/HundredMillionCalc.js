// 計算回数
const ITERATIONS = 100_000_000;  // 1億回の繰り返し

console.log(`計算回数: ${ITERATIONS.toLocaleString()}`);

// 計算実行
let result = 0.0;
for (let i = 0; i < ITERATIONS; i++) {
    result += Math.sin(i) * Math.cos(i);
}

console.log(`計算結果: ${result}`);