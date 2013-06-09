require 'rest-client'
require 'json'

base_url = "https://api.23andme.com/1/demo"
token = "fdab6a6892b198e40c2484bf2121f761"
headers = {Authorization: "Bearer #{token}"}

class Person
    attr_accessor :id, :first_name, :last_name
end

response = RestClient.get base_url + "/names/", headers=headers
data = JSON.load response

# profiles is an array.
profiles = data["profiles"]
person = Person.new
person.id = profiles[0]["id"]
person.first_name = profiles[0]["first_name"]
person.last_name = profiles[0]["last_name"]

puts "Hello, #{person.first_name} #{person.last_name}!"
