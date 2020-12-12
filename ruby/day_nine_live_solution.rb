require_relative './day_nine_live'

input = File.read('../puzzles/day_nine/input.txt')


cypher = Cypher.new(input)
invalid = cypher.find_first_invalid_number(25)
puts "Part 1: #{invalid}"
puts "Part 2: #{cypher.sum_contiguous_range(invalid)}"
