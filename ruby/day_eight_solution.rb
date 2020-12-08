require_relative './day_eight'

input = File.read('../puzzles/day_eight/input.txt')

boot = BootChecker.new(input)

puts "Part 1: #{boot.loop_check}"
puts "Part 2: #{boot.halt_check}"
