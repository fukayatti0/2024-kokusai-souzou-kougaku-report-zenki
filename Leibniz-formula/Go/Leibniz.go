package main

import (
	"fmt"
	"math"
)

// ライプニッツ公式計算
func calculateLeibnizFormula(n int) float64 {
	piApprox := 0.0
	sign := 1.0
	for i := 0; i < n; i++ {
		piApprox += sign / (2.0*float64(i) + 1.0)
		sign = -sign
	}
	piApprox *= 4.0
	return piApprox
}

func main() {
	// 計算する項数(1億)
	n := 100000000

	// ライプニッツ公式計算
	piApprox := calculateLeibnizFormula(n)

	// 誤差
	calculationError := math.Pi - piApprox

	fmt.Printf("円周率近似値  : %v\n", piApprox)
	fmt.Printf("計算誤差      : %v\n", calculationError)
}
