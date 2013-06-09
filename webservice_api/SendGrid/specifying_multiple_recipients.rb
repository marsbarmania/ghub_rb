require "httparty"
require "json"
url = "https://sendgrid.com/api/mail.send.json"

smtpapi_header = {
  "to" => [ "hiroki_nakashima@yappa.co.jp","Hiroki.Nakashima@gmail.com" ]
}

response = HTTParty.post url, :body => {
  "api_user" => "API_USERNAME",
  "api_key" => "API_KEY",
  "to" => "override.this@email.com",
  "from" => "codecademy@sendgrid.me",
  "subject" => "Using the SMTP API header for email awesomesauce",
  "html" => "Hey -name-,<br />-body-",
  "x-smtpapi" => JSON.generate(smtpapi_header)
}

response.body