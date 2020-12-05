require_relative './day_five'

input = File.read('../puzzles/day_five/input.txt')

passes = BoardingPassList.new(input)
highest_id = list.passes.map(&:seat_id).max
puts "PART 1: #{highest_id}"
