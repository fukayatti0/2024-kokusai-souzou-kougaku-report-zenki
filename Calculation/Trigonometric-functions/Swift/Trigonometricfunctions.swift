import Foundation

let iterations = 100_000_000

print("計算回数: \(iterations)")

let startTime = DispatchTime.now()

var result = 0.0
for i in 0..<iterations {
    result += sin(Double(i)) * cos(Double(i))
}

print("計算結果: \(result)")