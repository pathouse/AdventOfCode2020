require_relative './day_two'

input = File.read('../puzzles/day_two/input.txt')

service = PasswordChecker.new(input)
puts "PART 1: #{service.count_valid(:count)}"
puts "PART 2: #{service.count_valid(:position)}"
