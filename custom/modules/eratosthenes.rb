module Eratosthenes
	def shift_out from, to
		origin = (from..to).to_a
		shifted = []
		bool = true
		# 0や1は素数ではないので削除
		origin.delete_if{|x| x == 0 or x == 1}
		# 繰り返す準備
		i = 0
		while bool
			candidate = origin[i]
			# origin配列の最初の値を候補として素数リストに追加
			# p candidate
			shifted.push(candidate)
			# 素数リストに追加した値の倍数を全て削除する
			# その値で割り切れるという事は素数ではないから。
			origin.delete_if{|x| x % candidate == 0}
			# 素数リストの最大値の平方がorigin配列の最大値より大きいければ繰り返し
			# 素数リストの最大値の平方がorigin配列の最大値より小さければ処理を終了する。
			if origin.last < candidate ** candidate
				bool = false;
			end
		end
		# 素数リスト：shiftedとorigin配列の残った要素を結合すると素数リストとなる。
		return shifted + origin
	end

	def shift_out2 from, to
		origin = (from..to).to_a
		x = 0
		bool = true
		# 0や1は素数ではないので削除
		origin.delete_if{|x| x == 0 or x == 1}
		# 繰り返す準備
		first = 0
		while bool
			candidate = origin[first]
			x |= (1 << candidate)
			origin.delete_if{|x| x % candidate == 0}
			if origin.last < candidate ** candidate
				bool = false;
			end
		end
		# originalの残りの要素を素数としてビットとして１をたてる
		origin.map{|n| x |= 1 << n}

		ret = []

		x.to_s(2).size.times do |i|
			ret << i if x[i] == 1
		end

		ret

	end

end

