keyboard = [
 ['.','@','-','_','/',':','~','1'],
 ['a','b','c','A','B','C','2'],
 ['d','e','f','D','E','F','3'],
 ['g','h','i','G','H','I','4'],
 ['j','k','l','J','K','L','5'],
 ['m','n','o','M','N','O','6'],
 ['p','q','r','s','P','Q','R','S','7'],
 ['t','u','v','T','U','V','8'],
 ['w','x','y','z','W','X','Y','Z','9']
]


input = '4444433555E5556661111999996667775553E'
row = -1
col = 0
output = ''

input.each_char do |num|
  # puts "num:#{num} row:#{row}"
  if num==row
    col += 1
  else
    unless row=='E' || row==-1
      # puts "input:#{input[num]} row:#{row} col:#{col} #{row.to_i-1} === #{col.to_i-1} #{keyboard[row.to_i-1][col.to_i]}"
      output << keyboard[row.to_i-1][col.to_i]
    end
    row = num
    col = 0
  end
end

puts output
