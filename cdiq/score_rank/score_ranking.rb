# coding: utf-8
# ------------------------------------------------------
# [必須] 1. 使用言語・動作環境
# Ruby 2.1.1
#
# [必須] 2. プログラムの特長・工夫した点等、アピールポイント
#  *シンプルにわかりやすい処理を実装するように心がけた
#    -クラス化することでオブジェクトの中で処理が完結するようにした
#    -記述方法を極力統一した
#
# [任意] 3. もし企業からのスカウトメールがきたらどのくらい積極的にアクションすると思いますか？
# 積極的に会ってみたいと思う
# ------------------------------------------------------

# Studentクラス
# 生徒の成績などを格納するクラス
class Student
  # 名前、各教科の成績スコア
  attr_accessor :name,:lang,:math,:eng,:social,:science,:total
  # 各教科の順位
  attr_accessor :ord_lang,:ord_math,:ord_eng,:ord_social,:ord_science,:ord_total

  # Studentオブジェクト生成
  #
  # ==== Args
  # info :: 名前、各教科のスコアの配列
  # ==== Return
  # 生成されたStudentオブジェクト
  def initialize(info)
    @name = info[0]
    @lang = info[1].to_i
    @math = info[2].to_i
    @eng = info[3].to_i
    @social = info[4].to_i
    @science = info[5].to_i
    @total = 0
    info.each_with_index do |num,index|
      # 生徒名はスキップ
      @total += num.to_i unless index==0
    end
  end

  # 各科目のランク値を代入する
  def set_rank_val(list)
    @ord_lang = list[0]
    @ord_math = list[1]
    @ord_eng = list[2]
    @ord_social = list[3]
    @ord_science = list[4]
    @ord_total = list[5]
  end

  # 各科目のランク値の配列を返す
  # ==== Return
  # ランク値配列
  def subject_rank
    # csvで書き出される行の順番の配列
    [@name,@ord_lang, @ord_math, @ord_eng, @ord_social, @ord_science, @ord_total]
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
  attr_accessor :student_data

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
      f.puts("生徒氏名,国語,数学,英語,社会,理科,合計")
      # カンマ区切りで書込み
      @student_data.each do |student|
        f.puts(student.subject_rank.join(','))
      end
    end
  end

private
  # 各Studentオブジェクトの科目得点を総合ランキング値に変換する
  def convert_to_rank
    # labelは科目のラベル格納用の配列
    # temp_tblはStudentクラスに渡すデータを格納する配列
    labels, temp_tbl = [:lang,:math,:eng,:social,:science,:total], []

    labels.map do |key|
      temp_tbl << score_to_rank(subject_score(key))
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

  # Studentクラスのプロパティ名から
  # その科目のスコア配列を取得する
  # ==== Return
  # scores配列
  def subject_score(keyword)
    scores = []
    @student_data.map do |student|
      unless student.nil?
        scores << student.send(keyword)
      end
    end
    scores
  end

end

in_file = "./seiseki/class_3c_input.csv"
out_file = "./seiseki/class_3c_out.csv"

# Rankingクラスをインスタンス化
rank = Ranking.new

# 読み込むファイルパスを渡す
rank.read_csv(in_file)

# 出力されるファイルパスを指定(ファイルが無ければ、作成する)
rank.output(out_file)
