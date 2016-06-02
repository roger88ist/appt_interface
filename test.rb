require 'httparty'

url = "http://localhost:3000/api/appointments"

# response = HTTParty.get(url)

# puts response["status"]

HTTParty.post(url,
  { 
    :body => {"appointment" => { "first_name" => "Juha", "last_name" => "Mikkola", "comments" => "This was done with httparty" }}.to_json,
    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  })

# response = HTTParty.get(url)
# puts response