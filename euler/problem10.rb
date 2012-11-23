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

sum_prime(n)
