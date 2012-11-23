# Problem 4
# 左右どちらから読んでも同じ値になる数を回文数という。
# 2桁の数の積で表される回文数のうち、最大のものは 9009 = 91 × 99 である。
# では、3桁の数の積で表される回文数のうち最大のものはいくらになるか。

def palindromic?(num)
  s = num.to_s
  count = s.length / 2
  count.times { |i|
    return false if s[i] != s.reverse[i]
  }
  true
end

def max_val(digit)
  _max = ("9" * digit).to_i
  _min = ("1" + ("0" * (digit - 1))).to_i

  result = []
  left = _max

  _max.times do |i|

    left -= i
    _max.downto(_min) do |n|
      val = left * n

      if palindromic?(val)
        result << val
        break if result.size == 1
      end
    end

     break if result.size == 1

  end

  result[0]

end

p max_val(3)
