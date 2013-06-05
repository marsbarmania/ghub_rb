require 'net/http'

# Need receipt data in the same dir.
receipt_data = "{ \"receipt-data\": \"#{open("./receipt").read}\"  }"

fetch_validation = lambda do |uri,receipt|
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    response = http.post('/verifyReceipt', receipt)
    response.body
  end
end

# Use net/http to post to apple sandbox server
production_uri = URI("https://buy.itunes.apple.com")

result = fetch_validation.call(production_uri,receipt_data)

/[0-9]+/ =~ result
# 21007 is sandbox verify
if $&.to_i == 21007
  puts "Sandbox"
  sandbox_uri = URI("https://sandbox.itunes.apple.com")
  puts fetch_validation.call(sandbox_uri,receipt_data)
else
  puts "Production"
  puts result
end
