require 'rest-client'
require 'json'

base_url = "https://api.23andme.com/1/demo"
token = "fdab6a6892b198e40c2484bf2121f761"
headers = {Authorization: "Bearer #{token}"}

response = RestClient.get base_url + "/ancestry/", headers=headers
data = JSON.load response

ancestry = data[0]["ancestry"]
ancestry["sub_populations"].each {
  |population|
  # Below, puts in the form "European: 87.0%"
  formatted_proportion = "%.1f" % (population['proportion'] * 100)
  puts "#{population['label']}: #{formatted_proportion}%"
}
