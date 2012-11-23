# Problem 6
# 最初の10個の自然数について、その和の二乗と、二乗数の和は以下の通り。
# 12 + 22 + ... + 102 = 385
# (1 + 2 + ... + 10)2 = 3025
# これらの数の差は 3025 - 385 = 2640 となる。
# 同様にして、最初の100個の自然数について和の二乗と二乗の和の差を求めよ。

def sum_multiple(num)
  sum = 0
  sum2 = 0

  num.times do |i|
    n = i + 1
    sum += n ** 2
    sum2 += n
  end
  multiple = sum2 ** 2
  p diff = multiple - sum
end

sum_multiple(100)
