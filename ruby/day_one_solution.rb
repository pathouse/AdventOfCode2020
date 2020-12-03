require_relative './day_one'

input = File.read('../puzzles/day_one/input.txt')

service = DayOne.new(input)
puts "PART 1: #{service.product_of_entries(2, 2020)}"
puts "PART 2: #{service.product_of_entries(3, 2020)}"
