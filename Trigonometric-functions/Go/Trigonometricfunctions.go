package main

import (
	"fmt"
	"math"
	"runtime"
	"sync"
)

const iterations = 100_000_000

func main() {
	fmt.Printf("計算回数: %d\n", iterations)
	
	// シングルスレッドバージョン
	fmt.Println("\n--- シングルスレッド実行 ---")
	
	resultSingle := 0.0
	for i := 0; i < iterations; i++ {
		resultSingle += math.Sin(float64(i)) * math.Cos(float64(i))
	}
	
	// マルチスレッドバージョン
	fmt.Println("\n--- マルチスレッド実行 ---")
	numCPU := runtime.NumCPU()
	fmt.Printf("使用CPU数: %d\n", numCPU)

	
	resultMulti := parallelCalculation(numCPU)
	
	fmt.Printf("計算結果: %f\n", resultMulti)
}

func parallelCalculation(numGoroutines int) float64 {
	var wg sync.WaitGroup
	var mu sync.Mutex
	
	result := 0.0
	iterPerGoroutine := iterations / numGoroutines
	
	for i := 0; i < numGoroutines; i++ {
		wg.Add(1)
		start := i * iterPerGoroutine
		end := start + iterPerGoroutine
		
		go func(start, end int) {
			defer wg.Done()
			localResult := 0.0
			
			for j := start; j < end; j++ {
				localResult += math.Sin(float64(j)) * math.Cos(float64(j))
			}
			
			mu.Lock()
			result += localResult
			mu.Unlock()
		}(start, end)
	}
	
	wg.Wait()
	return result
}