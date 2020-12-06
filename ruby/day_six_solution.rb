require_relative './day_six'

input = File.read('../puzzles/day_six/input.txt')

counter = QuizCounter.new(input)
puts "PART 1: #{counter.sum_uniq_answers}"
puts "PART 2: #{counter.sum_everyone_answers}"
