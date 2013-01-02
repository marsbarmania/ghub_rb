class Array

  def quick_sort(left=0, right=length-1)
  
    return self if length <= 1
  
      base = self[left] if base.nil?
      search_big, search_small = left + 1, right
  
      while search_big < search_small
  
          if self[search_big] < self[left] && search_big < right
              search_big += 1
          end
  
          if self[search_small] >= self[left] && search_small > left
              search_small -= 1
          end
  
          if search_big < search_small
              # p "Left:#{search_big} is greater(#{[search_big]}) than base Right:#{search_small} => #{[search_small]}"
              replace = self[search_big]
              self[search_big], self[search_small] = self[search_small], replace
          end
  
      end
  
      if (right - left != 1) || self[left] > self[search_small]
          replace = self[left]
          self[left], self[search_small] = self[search_small], replace
      end
  
      if left < search_small - 1
          quick_sort(left, search_small - 1)
      end
  
      if search_small + 1 < right
          quick_sort(search_small + 1, right)
      end
  
      self
  end
  
  def bubble_sort
  
      head, tail = 1, self.size - 1
      target = tail
      tmp, increment = nil, 0
  
      while head < tail
  
          until target < head
  
              if self[target] < self[target - 1]
                  tmp = self[target]
                  self[target], self[target - 1] = self[target - 1], tmp
              end
  
              unless target == head
                  target -= 1
              else
                  head += 1
                  break
              end
          end
          target = tail
          increment += 1
      end
  
      self
  end
  
  # 挿入ソート：単純挿入法
  def insert_sort
  
      # ソート済みインデックス
      sorted_end = 0
      candidate_value = nil
  
      while sorted_end < self.length - 1
          # 入れ替え候補
          candidate_value = self[sorted_end + 1]
          # 配列を右から左へ捜査する
          count = sorted_end
  
          # self[count] > candidate_value : 一つずらす、位置入替
          # self[count] < candidate_value : 位置確定=>処理終了
          while count >= 0
              if self[count] < candidate_value
                  break
              else
                  self[count + 1], self[count] = self[count], candidate_value
              end
              count -= 1
          end
  
          # 確定済み範囲を広げる
          sorted_end += 1
      end
      self
  end
  
  def shell_sort
  
      # ソート間隔用の配列を作成
      # ステップ：3 x n + 1
      sort_skip = Array.new
      0.upto(self.length / 2) do |i|
          sort_skip << begin
              3 * sort_skip[i - 1] + 1
          rescue
              # 1をデフォルトで設定する
              1
          end
      end
  
      # 抽出ステップ幅の値の配列:実行順にする
      # sample : [4, 2, 1]
      sort_skip.delete_if{|val| val > self.length }.reverse!
  
  
      # ソート処理
      sort_skip.each do |step_range|
  
          # ステップ幅のグループ分け
          step_range.times do |group_num|
  
              # 処理グループを格納しておく配列
              # ステップ分グループが必要になる
              grp = []
  
              # 抽出基点を設定
              target_index = group_num
  
              self.each_index do |index|
  
                  if index == target_index
                      grp << self[index]
                      # p "inserted val is #{self[index]}"
                      target_index += step_range
                  end
  
              end
  
              # この段階で挿入ソートする
              grp.insert_sort
  
              # ソートした値適応して元の配列にソートした状態でもどす
              grp.each_index do |val_in_group|
                  insert_target_index = (step_range * val_in_group) + group_num
                  # p insert_target_index
                  self[insert_target_index] = grp[val_in_group]
              end
          end
      end
  
      self
  end
  
  
  
  def select_sort
  
      current = self.length - 1
  
      while current > 0
          # max値を範囲指定した中で選ぶ
          range_splited = self[0, current + 1]
          switch_tmp = self[current]
          # 入換え処理
          self[current] = self[index(range_splited.max)]
          self[index(range_splited.max)] = switch_tmp
          current -= 1
      end
  
      self
  end

end

