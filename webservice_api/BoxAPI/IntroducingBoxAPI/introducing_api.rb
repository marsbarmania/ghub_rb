# The protocol describes how the information will be sent to the API.
# In this case, we use https to ensure that everything gets to Box
# securely.
protocol = "https://"

# This is whose API you're using
base = "api.box.com"

# APIs can have different versions. We're using the latest and greatest
# version of the Box API, 2.0!
version = "/2.0"

# When we put it all together, you should be able to use these pieces
# to say we're going to *securely* use the *2.0 version* of *Box's API*
api_url = protocol + base + version

puts api_url
