require_relative './day_seven_live'

input = File.read('../puzzles/day_seven/input.txt')

graph = Graph.build(input)
part_1 = graph.all_outers('shiny gold').uniq.count
part_2 = graph.product_of_children('shiny gold') - 1

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"
