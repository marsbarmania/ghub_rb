require 'rubygems'
require 'oauth'
require 'json'

# Parse a response from the API and return a user object.
def parse_user_response(response)
  user = nil

  # Check for a successful request
  if response.code == '200'
    # Parse the response body, which is in JSON format.
    # ADD CODE TO PARSE THE RESPONSE BODY HERE
    user = JSON.parse response.body

    # Pretty-print the user object to see what data is available.
    puts "Hello, #{user["screen_name"]}!"
  else
    # There was an error issuing the request.
    puts "Expected a response of 200 but got #{response.code} instead"
  end

  user
end

# All requests will be sent to this server.
baseurl = "https://api.twitter.com"

# Verify credentials returns the current user in the body of the response.
address = URI("#{baseurl}/1.1/account/verify_credentials.json")

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# If you entered your credentials in the previous
# exercise, no need to enter them again here. The
# ||= operator will only assign these values if
# they are not already set.
consumer_key ||= OAuth::Consumer.new "ENTER IN EXERCISE 1", ""
access_token ||= OAuth::Token.new "ENTER IN EXERCISE 1", ""

# Issue the request.
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token
http.start
response = http.request(request)
user = parse_user_response(response)
