require_relative './day_seven'

input = File.read('../puzzles/day_seven/input.txt')

bag_graph = BagGraph.build(input.split("\n"))
puts "PART 1: #{bag_graph.all_parents('shiny gold').uniq.count}"
puts "PART 2: #{bag_graph.count_children('shiny gold') - 1}"
