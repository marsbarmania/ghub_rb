# These gems make calling the API a piece of cake
require 'rest-client'
require 'json'

# This is the base URL -- we'll add endpoints to it for specific data
base_url = "https://api.23andme.com/1/demo"
# This is the demo token, that gives you access to simulated data
token = "fdab6a6892b198e40c2484bf2121f761"

class Person
  attr_accessor :id, :first_name, :last_name
end
