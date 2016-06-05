def can_I_book(array)
	start1 = array[0][0]
	end1 = array[0][1]
	start2 = array[1][0]
	end2 = array[1][1]

	if start1 < end2 && end1 > start2
		return false
	end
	true
end

first_combo = [[1,3], [4,7]]
#false

second_combo = [[4,7],[1,3]]
#false

third_combo = [[1,6],[4,9]]
#true

fourth_combo = [[2,5],[2,3]]
#true

fifth_combo = [[1,10],[3,6]]
#true

sixth_combo = [[3,6],[1,10]]
#true
combo7 = [[1,5],[5,10]]
#true
combo8 = [[5,10],[1,5]]

puts "first combo is true: #{can_I_book(first_combo)}"
puts "second combo is true: #{can_I_book(second_combo)}"
puts "third combo is false: #{can_I_book(third_combo)}"
puts "fourth combo is false: #{can_I_book(fourth_combo)}"
puts "fifth combo is false: #{can_I_book(fifth_combo)}"
puts "sixth combo is false: #{can_I_book(sixth_combo)}"
puts "combo7 is true: #{can_I_book(combo7)}"
puts "combo8 is true: #{can_I_book(combo8)}"