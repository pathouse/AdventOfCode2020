require_relative './day_nine'

input = File.read('../puzzles/day_nine/input.txt')
cipher = Cipher.new(input)

puts "Part 1: #{cipher.first_invalid_number(25)}"
puts "Part 2: #{cipher.contiguous_range_min_max_sum(25)}"
