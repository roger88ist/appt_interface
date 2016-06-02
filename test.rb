require 'httparty'

class Interface
	attr_accessor :url

	def initialize
		@url = "http://localhost:3000/api/appointments"
		puts "You are going to see a specific appointment"
		puts see_specific_appointment
	end

	# This is the code for a GET request
	def see_appointments(address)
		response = HTTParty.get(address)
		response.body
	end

	def see_specific_appointment
		id = grab_id
		address = @url + "/" + id
		see_appointments(address)
	end

	def ask_id_question(action)
		puts "Provide appointment_id for the appointment you would like to #{action}:\n"
		print ">"
	end

	def grab_id
		loop do
			ask_id_question("see")
			id = gets.chomp
			if id.to_i > 0
				return id
			end
		end
	end

	# This is the code for a POST request
	def create_appointment
		response = HTTParty.post(@url,
		  { 
		    :body => {"appointment" => { "first_name" => retrieve_first_name, 
		    															"last_name" => retrieve_last_name, 
		    															"start_time" => get_appointment_start_time, 
		    															"comments" => leave_comment }}.to_json,
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

	def get_appointment_start_time
		puts "Enter Appointment Start Time:"
		# hour = get_hour
		# minute = get_minute
		# ampm = am_or_pm
		"#{get_year}-#{get_month}-#{get_day} #{get_hour}:#{get_minute}#{am_or_pm}"
	end

	def get_hour
		loop do
			puts "Enter hour: (You will be asked for AM or PM shortly)\n"
			print ">"
			answer = gets.chomp
			if ("1".."12").include?(answer)
				return answer
			end
		end
	end

	def get_minute
		loop do
			puts "Enter minutes: (You will be asked for AM or PM shortly)\n"
			print ">"
			answer = gets.chomp
			if ("0".."59").include?(answer)
				return answer
			end
		end
	end

	def am_or_pm
		loop do
			puts "AM or PM?\n"
			print ">"
			answer = gets.chomp.downcase
			if ["am","pm"].include?(answer)
				return answer
			end
		end
	end

end


instance = Interface.new