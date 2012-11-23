# Problem 2
# フィボナッチ数列の項は前の2つの項の和である。 最初の2項を 1, 2 とすれば、最初の10項は以下の通りである。
#  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
# 数列の項の値が400万を超えない範囲で、偶数値の項の総和を求めよ。
# Note:この問題は最近更新されました。お使いのパラメータが正しいかどうか確認してください。

def fibonacci_series (max, n1 = 1, n2 = 2)

  total = 0
  loop do
    break if n1 >= max
    total += n1 if n1.even?
    n1, n2 = n2, n1 + n2
  end

  p total
end

fibonacci_series(4000000)
