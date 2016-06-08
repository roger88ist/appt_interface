require 'httparty'
def send_post_request(appointment)
	HTTParty.post("https://rogeriosappointment.herokuapp.com/api/appointments",
	{
		:body => {"appointment" => appointment}.to_json,
		:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
	})
end


line_num = 0
appointment = {}
appointment["comments"] = ""
File.open("appt_data.csv").each do |line|
	if line_num > 0 
		arguments = line.split(",")
		appointment["start_time"] = arguments[0]
		appointment["end_time"] = arguments[1]
		appointment["first_name"] = arguments[2]
		appointment["last_name"] = arguments[3]
		response = send_post_request(appointment)
		puts response.body
		# Appointment.create(appointment)
	end
	line_num += 1
end

