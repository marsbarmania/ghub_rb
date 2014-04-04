def pick(str,group)

  # strの文字列がすべてgroupに存在しなければならない
  # match_count = 0
  # str.each_char{ |ch|
  #   match_count += 1 if group.index(ch)
  # }

  boat ||= []

  if str == 'ST'
    if group.join.count('S') >= 1 && group.join.count('T') >= 1
      str.each_char { |ch| boat.push(ch)}
      group.each_with_index{ |c,index|
        str.each_char{ |s|
          group.delete_at(index) if group[index] == s
        }
      }
    end

  else
    #
    if group.join.count(str) >= str_type.size
      group.each_with_index do |ch,index|
        if ch == str
          boat.push(ch)
          group.delete_at(index)
          break
        end
      end
    end
  end

  # str.sizeとmatch_countは同数であれば、処理する
  # if match_count == str.size

  #   if str == 'ST'
  #     str.each_char { |ch| boat.push(ch)}
  #     group.each_with_index{ |c,index|
  #       str.each_char{ |s|
  #         group.delete_at(index) if group[index] == s
  #       }
  #     }

  #   else
  #     #
  #     group.each_with_index do |ch,index|
  #       if ch == str
  #         boat.push(ch)
  #         group.delete_at(index)
  #         break
  #       end
  #     end
  #   end
  # else
  #   # 処理せずそのまま
  # end
  return group,boat
end


# def pick(str_type,group)




#   str = case str_type
#         when 'TT' then 'T'
#         when 'ST' then 'ST'
#         when 'SS' then'S'
#         end

#   boat = []
#    # strの文字列がすべてgroupに存在しなければならない
#    puts group.join.count(str)


#   if str == 'ST'

#     if group.join.count('S') >= 1 && group.join.count('T') >= 1
#       str.each_char { |c| boat.push(c)}
#       if group.size == 2
#         # すべてboatに移動するので
#         group = []
#       else
#         num = 0
#         index = 0
#         while index < boat.size
#           val = group[num]
#           # puts "val=>#{val} val2=>#{str[index]}"
#           if str[index] == val
#             group.delete_at(num)
#             index += 1
#           end
#           num += 1
#         end
#       end
#     end
#   else
#     if group.join.count(str) >= str_type.size
#       num = 0
#       while boat.size < 2
#         val = group[num]
#         if val == str
#           boat.push(val)
#           group.delete_at(num)
#           # puts "val=#{val} num=#{num}"
#           num = 0
#         else
#           num += 1
#         end
#       end
#     end

#   end

#   puts " type=>#{str_type} str=>#{str} group=>#{group} boat=>#{boat}"
#   return group, boat
# end

# puts "#{pick('ST',['T','T','T'])}"
