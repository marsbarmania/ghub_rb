def shift_move(type,n,m)
  case type
  when '*'
    # bit shiftできるカウント
    cnt = 0
    # 一時的に変数でテスト
    t = 1
   while t < m
    # Shift left
    t = t << 1
    if t <= m
      # まだいけるかも
      cnt += 1
    else
      # もどす
      t = t >> 1
      # 終了
      break
    end
   end
   # 差分を計算してのちほど加算する値
   add_num = 0
   # 割る値との差が加算する値を足す回数になるので
   # 足し算で計算する
   (m - t).times{ add_num += n }
   # これが結果 左シフトの結果と加算する値
   (n << cnt) + add_num

  when '/'
    res = 0
    while n >= m
      # 割る値を代入
      temp_m = m
      # 商（割る値）
      quotient = 1
      while n >= temp_m
        temp_m = temp_m << 1
        quotient = quotient << 1
      end
      temp_m = temp_m >> 1
      quotient = quotient >> 1
      n = n - temp_m
      res = res + quotient
    end
    res
  end
end

# p shift_move('*',30,6)
# p shift_move('*',110,2)

# p shift_move('/',30,6)
# p shift_move('/',110,2)
