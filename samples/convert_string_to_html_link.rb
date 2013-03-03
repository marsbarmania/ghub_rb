# encoding: UTF-8
def change_url_to_link text
  pattern = "https?://[a-zA-Z0-9.]{2,}(:[0-9]+)?(/[-_.!~*a-zA-Z0-9;/?:@&=+$,%#]+)?"
  /#{pattern}/ =~ text
  text.gsub(/#{pattern}/,"<a href="+$&.to_s+">"+$&.to_s+"</a>")
end

# text = "Merry X'mas http://www.yahoo.com"
# puts make_link_tag text
