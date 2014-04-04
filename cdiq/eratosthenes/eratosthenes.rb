module Eratosthenes
  # 与えられたn個の数字より小さい数の中で素数がいくつあるのか
  def primenumber_count(n)
    # 与えられたnは含まないので
    n -= 1
    # 0や1は素数ではない
    return 0 if n < 2
    # 2は素数
    return 1 if n == 2
    # n番目までの配列をつくる
    original_range = (2..n).to_a
    # 素数として抜き出した値を格納する配列
    shifted = []

    # ループする準備
    bool, first = true, 0
    while bool
      candidate = original_range[first]
      # original_range配列の最初の値を候補として素数リストに追加
      shifted.push(candidate)
      # 素数リストに追加した値の倍数を全て削除する
      original_range.delete_if{|x| x % candidate == 0}
      # ループ抜ける処理:２乗した値が元の配列の最大値より大きかったら
      # 素数はもう存在しないことになる
      if original_range.last < candidate ** candidate
        bool = false
      end
    end
    # 素数リスト：shiftedとorigin配列の残った要素を結合すると素数リストとなる。
    return (shifted + original_range).size
  end
end

include Eratosthenes

question = [2, 5, 10, 19, 54, 224, 312, 616, 888, 977]

question.map { |e| puts primenumber_count(e)}
