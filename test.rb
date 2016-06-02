require 'httparty'


url = "http://localhost:3000/api/appointments"


# This is the code for a GET request
response = HTTParty.get(url)
puts response["status"]

# This is the code for a POST request
response = HTTParty.post(url,
  { 
    :body => {"appointment" => { "first_name" => "Alex", "last_name" => "Vera", "comments" => "Coming into Scale" }}.to_json,
    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  })
puts response.body



