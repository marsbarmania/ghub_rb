require 'rexml/doctype'

file = File.open("pets.txt")
doc = REXML::Document.new file

doc.elements.each("pets/pet/name") do |element|
	puts element
end

require 'json'

pets = File.open("pets.txt", "r")

doc = ""
pets.each do |line|
  doc << line
end
pets.close

puts JSON.parse(doc)
