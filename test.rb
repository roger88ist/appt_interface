require 'httparty'

class Interface
	attr_accessor :url

	def initialize
		@url = "http://localhost:3000/api/appointments"
		main_menu
	end

	def main_menu
		system "clear"
		continue = true
		while continue
			walk_on = first_question
			case walk_on
			when "1"
				#search appointments
				puts get_appointments_by_day
			when "2"
				#create an appointment
				puts create_appointment
			when "3"
				#update an appointment
				puts update_appointment
			when "4"
				#delete an appointment
				puts delete_appointment
			else
				continue = false
			end
		end
	end

	def wait
		puts "Hit Enter When You Are Ready to Continue."
		gets
		system "clear"
	end

	def first_question
		loop do	
			puts "What would you like to do? (enter number)"
			puts "1. Search appointments."
			puts "2. Create an appointment."
			puts "3. Update an appointment."
			puts "4. Delete an appointment."
			puts "5. Exit application.\n"
			print ">"
			answer = gets.chomp
			system "clear"
			if ("1".."5").include?(answer)
				return answer
			end
		end
	end
	# this method allows client to receive json of appointments based on date
	def get_appointments_by_day
		search = single_or_range
		case search
		when "s"
			single_day_search
		else
			multi_day_search
		end
	end

	def single_day_search
			start = get_starting_date_range
			ending = add_one_day(start)
			address = @url + "/q?start_time=#{start}&end_time=#{ending}"
			response = HTTParty.get(address)
			response.body
	end

	def multi_day_search
		start = get_starting_date_range
		ending = add_one_day(get_ending_date)
		address = @url + "/q?start_time=#{start}&end_time=#{ending}"
		response = HTTParty.get(address)
		response.body
	end

	def get_ending_date
		puts "Now provide the ending date:"
		get_starting_date_range
	end

	def get_starting_date_range
		year = get_year
		month = get_month
		day = get_day
		"#{format_leading_zero(year.to_i)}-#{format_leading_zero(month.to_i)}-#{format_leading_zero(day.to_i)}"
	end

	def format_leading_zero(int)
		int < 10 ? "0#{int}" : "#{int}"
	end

	def add_one_day(starting_point)
		split = starting_point.split("-")
		start = Time.new(split[0].to_i, split[1].to_i, split[2].to_i)
		ending = start + 86400
		ending_month = format_leading_zero(ending.month)
		ending_day = format_leading_zero(ending.day)
		ending_date = "#{ending.year}-#{ending_month}-#{ending_day}"
	end

	def single_or_range
		loop do
			puts "Do you want to see appointments for a (s)ingle day or a (r)ange of days?\n"
			print ">"
			answer = gets.chomp.downcase
			if ["s","r"].include?(answer)
				return answer
			end
		end
	end

	# This is the code for a GET request
	def see_appointments(address)
		response = HTTParty.get(address)
		response.body
	end

	def see_specific_appointment
		id = grab_id("see")
		address = @url + "/" + id
		see_appointments(address)
	end

	def grab_id(action)
		loop do
			ask_id_question(action)
			id = gets.chomp
			if id.to_i > 0
				return id
			end
		end
	end

	def ask_id_question(action)
		puts "Provide appointment_id for the appointment you would like to #{action}:\n"
		print ">"
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
		id = grab_id("update")
		address = @url + "/" + id
		update_value = what_to_update
		key = format_value(update_value)
		if update_value == "s"
			response = change_start_time(address, key, get_appointment_start_time)
		else
			response = change_data(address, key)
		end
		response.body
	end

	def change_start_time(address, key, method)
		HTTParty.put(address,
		{
			:body => {"appointment" => { key => method }}.to_json,
			:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
		})
	end

	def change_data(address, key)
		HTTParty.put(address,
				{
					:body => {"appointment" => { key => new_value(key) }}.to_json,
					:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
				})
	end

	def what_to_update
		loop do	
			puts "What would you like to update?"
			puts "(F)irst Name, (L)ast Name, (S)tart Time, (C)omments:\n"
			print ">"
			answer = gets.chomp.downcase
			if ["f","l","s","c"].include?(answer)
				return answer
			end
		end
	end

	def format_value(letter)
		idx = ["f","l","s","c"].index(letter)
		["first_name", "last_name", "start_time", "comments"][idx]
	end

	def new_value(string)
		puts "Enter the new value for #{string}:\n"
		print ">"
		answer = gets.chomp
	end	

	#This is the code for a DELETE request	
	def delete_appointment
		id =  grab_id("delete")
		address = @url + "/" + id
		response = HTTParty.delete(address)
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
			puts "Enter Year: (2013 through 2017)\n"
			print ">"
			answer = gets.chomp
			if ("2013".."2017").include?(answer)
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