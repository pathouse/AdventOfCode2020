require_relative './day_eleven'

input = File.read('../puzzles/day_eleven/input.txt')

game = GameOfSeats.new(input)
puts "Part 1: #{game.simulate}"

game = GameOfSeats.new(input)
puts "Part 1: #{game.simulate_v2}"
