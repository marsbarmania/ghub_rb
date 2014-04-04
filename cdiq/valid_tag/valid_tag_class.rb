# Ruby Version 2.0.0

class ValidTag

  def initialize
    @ignore_list = ["img", "p", "input", "li","br"]
  end

  def check html_str
    # タグを配列に格納
    tags = html_str.scan(/<\/?[^>]*>/)
    # 閉じタグの存在しないものは無視するので、リストから削除する
    @ignore_list.map{|ignore_item|
      # 終了タグを無視してもいいので、要素から削除してしまう。
      tags.reject! {|t| t.downcase.match Regexp.new "<#{ignore_item}(.+)?>" }
    }
    # ペアで同じ順序で表示されない場合のカウント変数
    unmatched_pair = 0
    # 必ずペアになるので要素は偶数個
    (tags.size/2).times do |i|
      # 閉じタグの後ろ文字を生成
      str = tags[i].scan(/<\/?(.+)>/).join << ">"
      # ペアになるはずのものと一緒になければ、閉じる順番が間違っている
      unmatched_pair += 1 unless tags[tags.size-i-1].end_with?(str)
    end
    # 開始タグと終了タグがセットになっていて表示される順番がそろっている場合は0
    # 0以上のときは終了タグが適切な位置にない
    result =  if unmatched_pair.zero?
                "OK"
              else
                "NG"
              end
  end
end

ValidTag.new.check("<html><body><div><span>This is a test text.</div></span></body></html>")
