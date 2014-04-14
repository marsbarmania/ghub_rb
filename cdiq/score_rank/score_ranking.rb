# coding: utf-8

# Studentクラス
# 生徒の成績などを格納するクラス
class Student
  # 成績スコア、各教科の順位の格納配列
  attr_accessor :score_data, :rank_conveted

  # Studentオブジェクト生成
  #
  # ==== Args
  # info :: 名前、各教科のスコアの配列
  # ==== Return
  # 生成されたStudentオブジェクト
  def initialize(info)
    @score_data= []
    total = 0
    # 名前とスコアを配列に格納する
    info.each_with_index do |val,index|
      unless index.zero?
        @score_data << val.to_i
        total += val.to_i
      else
        @score_data << val
      end
    end
    # 最後の要素絡むに合計カラムを追加
    @score_data << total

  end

  # 各科目のランク値を代入する
  def set_rank_val(list)
    @rank_conveted = list
    # 名前を先頭に追加
    @rank_conveted.unshift(@score_data[0])
  end

  # 各科目のランク値の配列を返す
  # ==== Return
  # ランク値配列
  def subject_rank
    # csvで書き出される行の順番の配列を返す
    @rank_conveted
  end

end

# Titleクラス
# 読み込んだタイトルラベル
class Title
  attr_accessor :prop
  def initialize(line)
    @prop = line.chomp.encode('utf-8', 'sjis').split(',')
    @prop << "合計"
  end

  # 文字列にして返す
  def to_s
    @prop.join(',')
  end

  # 要素数の長さ
  def size
    @prop.size
  end
end

# Rankingは成績を順位付けを実装するクラス
#
# SAMPLE
#  rank = Ranking.new
#  rank.read_csv "read_file_path"
#  rank.output "output_file_path"
class Ranking
  # Studentクラスオブジェクトを格納
  attr_accessor :student_data ,:title

  # Rankingオブジェクト生成
  #
  # ==== Return
  # 生成されたRankingオブジェクト
  # @student_dataを初期化する
  def initialize
    @student_data = Array.new
  end

  # filepathのデータを読み込み、
  # Studentクラスのインスタンスを生成しそのプロパティに設定する
  def read_csv(filepath)
    csv = File.open("#{filepath}","r") do |f|
      index = 0
      f.each_line do |line|
        # 最初のタイトル行はスキップ
        unless index == 0
          info = line.encode('utf-8', 'sjis').split(",")
          # infoデータでStudentクラスインスタンスを初期化する
          @student_data << Student.new(info)
        else
          # タイトル行
          @title = Title.new(line)
        end
        index += 1
      end
    end
  end

  # filepathに新規ファイルを作成し、ランキングデータを出力
  def output(filepath)
    # 各Studentの特典をランク値に変換
    convert_to_rank

    # 出力用のファイル
    File.open("#{filepath}","w") do |f|
      # タイトル行
      f.puts(@title.to_s.encode('sjis', 'utf-8'))
      # カンマ区切りで書込み
      @student_data.each do |student|
        # エンコードをShift_JISに
        f.puts(student.subject_rank.join(',').encode('sjis', 'utf-8'))
      end
    end
  end

private
  # 各Studentオブジェクトの科目得点を総合ランキング値に変換する
  def convert_to_rank
    # temp_tblはStudentクラスに渡すデータを格納する配列
    temp_tbl = []

    @title.size.times do |index|
      unless index.zero?
        temp_tbl << score_to_rank(subject_score(index))
      end
    end

    # temp_tblの行と列を入れ替え(Array#transpose)をして
    # Student#set_subject_rankメソッドでランク値を設定
    temp_tbl.transpose.each_with_index do |list,index|
      @student_data[index].set_rank_val(list)
    end

  end

  # スコア配列をランキング順位値に
  # 変換してその配列を返す
  # ==== Return
  # rank配列
  def score_to_rank(arr)
    rank = []
    # ループ処理
    arr.each_with_index do |target,current_index|
      cnt_num = 0
      arr.each_with_index do |val,index|
        # 比較する対象が自分自身のときは行わない
        unless current_index == index
          # 自分自身の値以上の時にカウントアップするようにして
          # 全体の中で何位なのかを算出する
          cnt_num += 1 if target >= val
        end
      end
      rank << arr.size - cnt_num
    end
    rank
  end

  # Studentクラスの
  # 科目のスコア配列を取得する
  # ==== Return
  # scores配列

  def subject_score(index)
    scores = []
    @student_data.map do |student|
      unless student.nil?
        scores << student.score_data[index]
      end
    end
    scores
  end
end


# 読み込むファイル
in_file = "./seiseki/class_3c_input.csv"
# 出力するファイル
out_file = "./seiseki/class_3c_out.csv"

# Rankingクラスをインスタンス化
rank = Ranking.new

# 読み込むファイルパスを渡す
rank.read_csv(in_file)

# 出力されるファイルパスを指定(ファイルが無ければ、作成する)
rank.output(out_file)
