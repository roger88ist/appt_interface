require 'httparty'


url = "http://localhost:3000/api/appointments"
url5 = "http://localhost:3000/api/appointments/5"


# This is the code for a GET request
# response = HTTParty.get(url)
# puts response["status"]

# This is the code for a POST request
# response = HTTParty.post(url,
#   { 
#     :body => {"appointment" => { "first_name" => "Alex", "last_name" => "Vera", "comments" => "Coming into Scale" }}.to_json,
#     :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
#   })
# puts response.body

# This is the code for a PUT request
# response = HTTParty.put(url5,
# 	{
# 		:body => {"appointment" => { "comments" => "Changed this comment using httparty put request"}}.to_json,
# 		:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
# 	})
# puts response.body

response = HTTParty.delete(url5)
puts response.body

