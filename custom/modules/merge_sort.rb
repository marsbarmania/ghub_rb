module MergeSort
    def merge_sort(arr = self, left = 0, right = self.size - 1)

        # 部分配列の要素数が１以下
        return if left >= right

        # 配列を分割する位置
        mid = (left + right) / 2

        # 部分配列の前半
        merge_sort(arr, left, mid)

        # 部分配列の後半
        merge_sort(arr, mid + 1, right)

        # すでにソートされている部分配列の前半と後半を昇順に統治（マージ）する
        merge(arr, left, mid, right)

        arr
    end

    # すでにソートされている部分配列の前半と後半を昇順に統治（マージ）する
    def merge(arr, left, mid, right)

        # 入れ替え用に配列を作成する
        tmp = []
        tmp += arr[left..mid]
        tmp += arr[mid+1..right]

        i, j, k = left, mid + 1, left

        # 左右の要素がある限り繰り返す
        while i <= mid && j <= right
            if tmp[i-left] < tmp[j-left]

                arr[k] = tmp[i-left]
                i += 1
            else

                arr[k] = tmp[j-left]
                j += 1
            end
            k += 1
        end

        # 左の要素がある限り繰り返す
        while i <= mid
            arr[k] = tmp[i-left]
            i += 1
            k += 1
        end

        # 右の要素がある限り繰り返す
        while j <= right
            arr[k] = tmp[j-left]
            j += 1
            k += 1
        end
        arr
    end

end
