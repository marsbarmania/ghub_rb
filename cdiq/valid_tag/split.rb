
tags="<abc> <ijk>"

ques="<abc>naka<ijk>abc<xxx><abc><ijk><abc>naka2<ijk>"

start=tags.split(' ').first
edge=tags.split(' ').last


ques.gsub(/#{start}(.*)#{edge}/){
  if $1.empty?
    puts "blank"
  else
    puts $1
  end
}
