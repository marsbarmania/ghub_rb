require "httparty"
url = "https://sendgrid.com/api/mail.send.json"

response = HTTParty.post url, :body => {
  "api_user" => "marsbarmania",
  "api_key" => "hir0kin7",
  "to" => "reg.marsbarmania@gmail.com",
  "from" => "mars@sendgrid.me",
  "subject" => "Hello world",
  "text" => "Congrats! You've sent your first email with SendGrid from your new account."
}

response.body