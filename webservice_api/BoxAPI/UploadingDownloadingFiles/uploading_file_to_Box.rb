require "rest-client"
require "json"

your_folder_id = "685995487"

your_filename = "my_upload_file" + ".txt"

f = File.open(your_filename, "w")

# Write a string to the file here–don't forget to close the file!

response = RestClient.post(
    "https://api.box.com/2.0/files/content",
    {
    	# We need to read the file again to send it to Box
        :myFile => File.new(your_filename, 'rb'),
        # This tells Box where to put the file
        :parent_id => your_folder_id
    },
    :authorization => "Bearer " << "m2YZQUDnyZDPZD4bmZoRXQHJR1oWgrbo"
)

puts JSON.parse(response.body)["entries"][0]["name"]
