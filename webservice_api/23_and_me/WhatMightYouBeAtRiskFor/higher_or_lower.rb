# The /risks/ endpoint returns also returns how at-risk the population is,
# not just the absolute lifetime risk for a person.
# Knowing this,
# we can compare each person's risk for each disease,
# to the population's, and see if it's higher or lower.

# When you finish this exercise, congratulations!
# You've got the basics of the 23andMe API.
# To create a developer account, get genotyped,
# and start pulling all sorts of real genetic data for your app,
# visit api.23andme.com!

# Loop through each disease,
# and put the disease description plus
# if the user is at higher, lower, or the same risk as the population.
#   For example "Alzheimer's: Higher".

require 'rest-client'
require 'json'

base_url = "https://api.23andme.com/1/demo"
token = "fdab6a6892b198e40c2484bf2121f761"
headers = {Authorization: "Bearer #{token}"}

response = RestClient.get base_url + "/risks/", headers=headers
data = JSON.load response

risks = data[0]["risks"]
risks.each {
  |risk|
    # Fill out the comparison variable
    comparison = case risk["risk"] <=> risk["population_risk"]
    when 0 then "#{risk["description"]}: Same"
    when 1 then "#{risk["description"]}: Higher"
    when -1 then "#{risk["description"]}: Lower"
    end

    puts "#{comparison}"
}
