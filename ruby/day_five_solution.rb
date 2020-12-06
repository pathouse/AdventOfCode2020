require_relative './day_five'

input = File.read('../puzzles/day_five/input.txt')

list = BoardingPassList.new(input)
highest_id = list.passes.map(&:seat_id).max
puts "PART 1: #{highest_id}"
puts "PART 2: #{list.find_seat_id}"
