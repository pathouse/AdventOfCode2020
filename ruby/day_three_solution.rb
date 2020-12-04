require_relative './day_three'

input = File.read('../puzzles/day_three/input.txt')

service = TobogganMap.new(input)
puts "PART 1: #{service.count_trees(right: 3, down: 1)}"
slopes = [
  { right: 1, down: 1 },
  { right: 3, down: 1 },
  { right: 5, down: 1 },
  { right: 7, down: 1 },
  { right: 1, down: 2 }
]
puts "PART 2: #{service.product_of_slopes(slopes)}"
