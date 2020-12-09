require_relative './day_eight_live'

input = File.read('../puzzles/day_eight/input.txt')

fixer = ProgramFixer.new(input)
prog = Program.new(fixer.instructions)
puts "Part 1: #{prog.run[:acc]}"
puts "Part 2: #{fixer.run}"
