# Problem 10
# 10以下の素数の和は2 + 3 + 5 + 7 = 17である.
# 200万以下の全ての素数の和を計算しなさい.

def prime?(n)
  return false if n == 0 || n == 1
  2.upto(n-1) do |i|
    return false if n.modulo(i).zero?
  end
  true
end

def sum_prime(n)
  tmp = 0
  (0..n).each do |i|
    tmp += i if prime?(i)
  end
  p tmp
end

n = 2000000

# slow
sum_prime(n)
