require 'httparty'

class Interface
	attr_accessor :url

	def initialize
		@url = "http://localhost:3000/api/appointments"
		puts "You are going to create an appointment"
		p create_appointment
	end

	# This is the code for a GET request
	def see_appointments
		response = HTTParty.get(@url)
		response.body
	end

	# This is the code for a POST request
	def create_appointment
		response = HTTParty.post(@url,
		  { 
		    :body => {"appointment" => { "first_name" => retrieve_first_name, "last_name" => retrieve_last_name, "comments" => leave_comment }}.to_json,
		    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
		  })
		response.body
	end

	# This is the code for a PUT request
	def update_appointment
		# The url variable needs to have an id => url/1
		response = HTTParty.put(url,
			{
				:body => {"appointment" => { "comments" => "Changed this comment using httparty put request"}}.to_json,
				:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
			})
		response.body
	end

	#This is the code for a DELETE request	
	def delete_appointment
		# The url variable needs to have an id => url/1
		response = HTTParty.delete(url)
		response.body
	end

	def retrieve_first_name
		puts "What's the first name?\n"
		print ">"
		gets.chomp
	end

	def retrieve_last_name
		puts "What's the last name?\n"
		print ">"
		gets.chomp
	end

	def leave_comment
		puts "Insert any comments if any.\n"
		print ">"
		gets.chomp
	end

	def get_year
		loop do
			puts "Enter Year: (2016 or 2017)\n"
			print ">"
			answer = gets.chomp
			if ("2016".."2017").include?(answer)
				return answer
			end
		end
	end

	def get_month
		loop do 
			puts "Enter Month: (1-12)\n"
			print ">"
			answer = gets.chomp
			if ("1".."12").include?(answer)
				return answer
			end
		end
	end

	def get_day
		loop do
			puts "Enter Day of the Month: (1-31)\n"
			print ">"
			answer = gets.chomp
			if ("1".."31").include?(answer)
				return answer
			end
		end
	end

end


instance = Interface.new