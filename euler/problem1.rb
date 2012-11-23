# Problem 1
# 10未満の自然数のうち、3 もしくは 5 の倍数になっているものは 3, 5, 6, 9 の4つがあり、
# これらの合計は 23 になる。
# 同じようにして、1,000 未満の 3 か 5 の倍数になっている数字の合計を求めよ

def multiple_three(limit)

  total = 0
  limit.times do |i|
    total += i if i % 3 == 0 || i % 5 == 0
  end
  total

end

p multiple_three(1000)
