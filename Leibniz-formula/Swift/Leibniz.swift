import Foundation

func calculateLeibnizFormula(n: Int) -> Double {
    var piApprox = 0.0
    var sign = 1.0
    for i in 0..<n {
        piApprox += sign / (Double(i) * 2.0 + 1.0)
        sign = -sign
    }
    return piApprox * 4.0
}

// 計算する項数(1億回)
let n = 100000000

// ライプニッツ公式計算
let piApprox = calculateLeibnizFormula(n: n)

// 誤差
let calculationError = Double.pi - piApprox


print("円周率近似値  : \(piApprox)");
print("計算誤差      : \(calculationError)");