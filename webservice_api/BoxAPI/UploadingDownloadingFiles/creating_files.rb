require "rest-client"
require "json"

body = {
    "name" => "marsbearmanson",
    "parent" => {
        "id" => "0"
    }
}

response = RestClient.post(
    "https://api.box.com/2.0/folders",
    JSON.generate(body),
    {:authorization => "Bearer " << "m2YZQUDnyZDPZD4bmZoRXQHJR1oWgrbo"}
)

puts "COPY THIS NUMBER DOWN: " + JSON.parse(response.body)['id']
# COPY THIS NUMBER DOWN: 685995487
