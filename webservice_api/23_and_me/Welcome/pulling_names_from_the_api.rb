require 'rest-client'
require 'json'

base_url = "https://api.23andme.com/1/demo"
token = "fdab6a6892b198e40c2484bf2121f761"
# We need to authenticate somehow. OAuth 2.0 uses Bearer tokens.
headers = {Authorization: "Bearer #{token}"}

class Person
  attr_accessor :id, :first_name, :last_name
end

# Instantiate a new Person:
person = Person.new

# Get the data from the /names/ endpoint,
# using the authentication headers
response = RestClient.get base_url + "/names/", headers=headers

# Use JSON.load to put the response into the data variable:
data = JSON.load response
