def calculate_leibniz_formula(n)
  pi_approx = 0.0
  sign = 1.0
  for i in 0...n
    pi_approx += sign / (2.0 * i + 1)
    sign = -sign
  end
  4 * pi_approx
end
  
require 'benchmark'

# 計算する項数(1億回)
n = 100000000

# 計測開始
pi_approx = 0
elapsed_sec = Benchmark.realtime do
  # ライプニッツ公式計算
  pi_approx = calculate_leibniz_formula(n)
end

# 誤差
calculation_error = Math::PI - pi_approx

puts "円周率近似値  : #{pi_approx}"
puts "計算誤差      : #{calculation_error}"
