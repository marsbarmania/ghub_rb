# encoding: UTF-8

def guess_store_name(name,list)
  maybe_this_name = ''
  match_max_count = 0
  space_trim = lambda{|x| x.gsub(/(\s|　)+/, '')}

  list.each do |s|
    # １文字ずつずらすためのインデックス
    index = 0
    # マッチしているMaxカウント
    current_count = 0

    # counting:カウントしているかどうかのflag
    # diff:カウントする時の差分
    counting, diff = false, 0

    # 空白スペースを削除
    trimed_str = space_trim.call(s)
    trimed_name = space_trim.call(name)

    while index < trimed_str.size do
      if counting
        # カウント中で比較している値が一致しなければ、カウントをやめて初期化
        unless trimed_str[index] == trimed_name[index - diff]
          counting, current_count = false, 0
        else
          # 比較している値が同一の場合
          current_count += 1
        end
      end

      # 対象文字の最初の１文字目と一致すれば、カウントを始める
      # puts "#{trimed_str[index]} #{name[0]}"
      if trimed_str[index] == trimed_name[0]
        counting, diff = true, index
        current_count += 1
      end
      # このインデックスはどんどんずらしていく
      index += 1
    end

    # puts "#{current_count}  #{match_max_count}  #{s}"
    if current_count > match_max_count
      maybe_this_name = s
      match_max_count = current_count
    end
  end

  puts maybe_this_name
end

# 【ケース１】 => 焼鳥 中目黒 いぐち
# name = '中目黒いぐち'
# store_list = ['焼鳥 中目黒 いぐち','串若丸 本店 くしわかまる','鳥よし 中目黒店 とりよし']

# 【ケース２】=> 「まるかつ水産 東京ミッドタウン店」
name = 'まるかつ水産 東京ミッドタウン店'
store_list = ['まるかつ水産 東京ミッドタウン店','まるかつ食堂 東京ミッドタウン店','東京ミッドタウン店 アンリ・ルルー','浅野屋 東京ミッドタウン店']

# 【ケース３】 => 寿司寿
# name = '寿司寿'
# store_list = ['六本木 寿司寿','寿し処 寿々 すず - 溜池山王/寿司','松葉寿し まつばずし - 六本木一丁目/寿司']

guess_store_name(name,store_list)
