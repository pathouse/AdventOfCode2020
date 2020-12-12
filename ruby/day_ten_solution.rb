require_relative './day_ten'

input = File.read('../puzzles/day_ten/input.txt')

chain = AdapterChain.new(input)
puts "Part 1: #{chain.product_of_diffs}"
puts "Part 2: #{chain.count_paths}"
