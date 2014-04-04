require "rubygems"
require "test/unit"

class AcrossRiver

  # ボートに移動させて、向こう岸に移動する構成を決めるモジュール
  module PassengerPicker
    # 左岸から右岸に行く場合のクラス
    class LR
      # 左→右は2人選ぶのでパターンは、TT,SS,STの3つ組合せ
      def pick(str_type,group)
        str = case str_type
              when 'TT' then 'T'
              when 'ST' then 'ST'
              when 'SS' then'S'
              end

        boat = []

        if str == 'ST'
          # strの文字列がすべてgroupに存在しなければならない
          if group.join.count('S') >= 1 && group.join.count('T') >= 1
            str.each_char { |c| boat.push(c)}
            if group.size == 2
              # すべてboatに移動するので
              group = []
            else
              num = 0
              index = 0
              while index < boat.size
                val = group[num]
                #
                if str[index] == val
                  group.delete_at(num)
                  index += 1
                end
                num += 1
              end
            end
          end
        else
          # strの文字列がすべてgroupに存在しなければならない
          if group.join.count(str) >= str_type.size
            num = 0
            while boat.size < 2
              val = group[num]
              if val == str
                boat.push(val)
                group.delete_at(num)
                # puts "val=#{val} num=#{num}"
                # 同じ文字が出現するため繰返し処理ために初期化
                num = 0
              else
                num += 1
              end
            end
          end
        end

        return group, boat
      end
    end

    # 右岸から左岸に行く場合のクラス
    class RL
      # 右→左は1人か2人の組合せ
      def pick(str,group)
        boat ||= []

         if str == 'ST'
          # strの文字列がすべてgroupに存在しなければならない
          if group.join.count('S') >= 1 && group.join.count('T') >= 1
            str.each_char { |ch| boat.push(ch)}
            group.each_with_index{ |c,index|
              str.each_char{ |s|
                group.delete_at(index) if group[index] == s
              }
            }
          end
        else
          # strの文字列がすべてgroupに存在しなければならない
          if group.join.count(str) >= str.size
            group.each_with_index do |ch,index|
              if ch == str
                boat.push(ch)
                group.delete_at(index)
                break
              end
            end
          end
        end
        return group,boat
      end
    end
  end

  attr_reader :left_side,:right_side,:boat,:position

  # コンストラクタ
  def initialize
    # 初期化
    @left_side,@right_side,@boat = [],[],[]
    @goal = '/SSSTTT'
    @position = 'left'
    @left_side = ['S','S','S','T','T','T']
    @picker = PassengerPicker::LR.new
  end

  # 目標の形になるまで繰り返すメソッド
  def carry_soldier_titan
    # 初期状態を表示
    puts self
    # 繰り返します
    until to_s == @goal
      case @position
      when 'left'
        go_to_right
        puts self
      when 'right'
        go_back_to_left
        puts self
      end
    end
  end

  # ボートに乗り込ませるパターンを作成するメソッド
  def pick(str_type,group)
    @picker.pick(str_type,group)
  end

  # 左岸から右岸に向かう組み合せを設定するメソッド
  def go_to_right
    # 左岸に残っている数が2であれば、それを移動させる
    if @left_side.size == 2
      @right_side += @left_side.clone
      @left_side = []
    else
       # LRクラスのpickerに設定しておく
      @picker = PassengerPicker::LR.new
      # Copyをつくる
      t_left,t_right,t_boat = @left_side.clone,@right_side.clone,[]
      # バランスのとれる組み合せがあれば、その組み合せでデータを入れ替える
      ['SS','TT','ST'].shuffle.each do |type|
        break if t_left.size == 1
        # 組み合せパターンによって決められたデータ群を取得する
        t_left, t_boat = pick(type,t_left)
        # 右岸のデータにボートに乗ったデータを加算する
        t_right += t_boat
        # boatが空の場合は処理しない
        if is_balanced?(t_left) && is_balanced?(t_right) && !t_boat.size.zero?
          # パワーバランスがとれている組み合せを移動後の設定とする
          @left_side,@right_side = t_left.clone,t_right.clone
          break
        else
          # パワーバランスがとれていなければ初期化して、処理の繰り返し
          t_left,t_right,t_boat = @left_side.clone,@right_side.clone,[]
        end
      end
    end
    @position = 'right'
  end

  # 右岸から左岸に向かう組み合せを設定するメソッド
  def go_back_to_left
    # RLクラスのpickerに設定
    @picker = PassengerPicker::RL.new
    t_left,t_right,t_boat = @left_side.clone,@right_side.clone,[]
    # 左岸にもどる組み合せで、パワーバランスのとれるパターンを決定
    # ランダムに選択するが、文字数の昇順で最小人数に
    ['ST','T','S'].shuffle.sort_by{|x| x.size}.each do |type|
      # STを移行する際は、残りが0にならないようにする
      next if type == 'ST' && t_right.size <= 2
      # 組み合せパターンによって決められたデータ群を取得する
      t_right, t_boat = pick(type,t_right)
      # 左岸のデータにボート移動のデータを加算
      t_left += t_boat
      # boatが空の場合はNG
      if is_balanced?(t_left) && is_balanced?(t_right) && !t_boat.size.zero?
        # データをコピー
        @left_side,@right_side = t_left.clone,t_right.clone
        break
      else
        # 初期化
        t_left,t_right,t_boat = @left_side.clone,@right_side.clone,[]
      end
    end
    @position = 'left'
  end

  # 兵士も巨人も同じ強さで、双方が同じ数、もしくは兵士の数が多いとパワーバランスが保てる
  def is_balanced?(group)
    soldier, titan = count_soldier_titan(group)
    # Soldierが0の時はTrue Soldierが1以上の時は判定する
    (soldier == 0) ? true : (soldier >= titan)? true : false
  end

  # 兵士と巨人の数を返すメソッド
  def count_soldier_titan(group)
    soldier = group.select{|x| x=='S'}.size
    titan = group.size - soldier
    return soldier, titan
  end

  # 状態を文字列に出力
  def to_s
    "#{left_side.sort!.join}/#{right_side.sort!.join}"
  end

end


# Test
class Test_RiverCrossing < Test::Unit::TestCase

  def setup
    @ar = AcrossRiver.new
  end

  def test_final_members_on_right
     @ar.carry_soldier_titan
    assert_equal(['S','S','S','T','T','T'],@ar.right_side)
  end

end
