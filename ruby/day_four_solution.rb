require_relative './day_fours'

input = File.read('../puzzles/day_four/input.txt')

passports = Passport.import(input)
puts "PART 1: #{passports.count(&:valid_by_presence?)}"
puts "PART 2: #{passports.count(&:valid_by_content?)}"
