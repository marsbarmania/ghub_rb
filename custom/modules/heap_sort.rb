module heap
  def heap_sort
    # A. heapを構築
    # 最初にheapの半分から構築
    # 末尾の位置を2で割ったsize/2 + 1が末尾の親になる
    i = self.size/2 + 1
    until i < 0
      down_heap(i, self.size-1)
      i -= 1
    end
    # B ソートを実行
    i = self.size - 1
    until i < 0
      tmp = self[i]
      # 根Node : self[0]とheapの末尾を入れ替える
      self[i] = self[0]
      self[0] = tmp

      i -= 1
      # heapを再構築
      down_heap(0,i)
    end
    self
  end

  # nはheap構造としての末尾インデックスを表す
  def down_heap(p, n)
    # Pが親で左の子を求めるにはP*2になる
    c = p * 2
    # cが末尾より大きい場合は、この位置(c)には子がないので終了
    return if c > n
    # 右の子があって左より大きければ左位置インデックスとして選択
    if c + 1 <= n && self[c+1] > self[c]
      # つまりインデックスを加算する
      c += 1
    end
    # 親の値の方が子の値より小さい場合、値を入れ替える
    if self[p] < self[c]
      # 入れ替え
      tmp = self[p]
      self[p] = self[c]
      self[c] = tmp
      # down_heapを繰返す
      down_heap(c,n)
    end
  end
end
