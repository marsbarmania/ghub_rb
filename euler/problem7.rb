# Problem 7
# 素数を小さい方から6つ並べると 2, 3, 5, 7, 11, 13 であり、6番目の素数は 13 である。
# 10001 番目の素数を求めよ

def prime_num?(num)
  return false if num <= 1
  2.upto(num-1){ |i|
    return false if num % i == 0
  }

  return true
end

def prime_index(num)

  primes = []

  start = num * 2

  target = 0
  loop do
    target += 1
    primes << target if prime_num?(target)
    break if primes.length == num
  end

  p primes.last
end

prime_index(10001)
