require 'benchmark'

# 計算回数
ITERATIONS = 100_000_000  # 1億回の繰り返し

puts "計算回数: #{ITERATIONS.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\\1,')}"

result = 0.0
duration = Benchmark.measure do
  ITERATIONS.times do |i|
    result += Math.sin(i) * Math.cos(i)
  end
end


puts "計算結果: #{result}"