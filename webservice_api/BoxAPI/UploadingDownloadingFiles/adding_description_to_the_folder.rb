require "rest-client"
require "json"

# This is the ID that you copied down in the last exercise
your_folder_id = "685995487"

# Add the "body" variable here
body = {}
body["description"] = "folder description sample"
response = RestClient.put(
    "https://api.box.com/2.0/folders/#{your_folder_id}",
    JSON.generate(body),
    :authorization => "Bearer " << "m2YZQUDnyZDPZD4bmZoRXQHJR1oWgrbo"
)

JSON.parse(response.body)["description"]
