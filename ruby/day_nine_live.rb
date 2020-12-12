class Cypher
  attr_reader :numbers

  def initialize(input)
    @numbers = parse_input(input)
  end

  def find_first_invalid_number(preamble)
    numbers.each_with_index do |num, idx|
      next if idx < preamble

      return num if numbers[idx - preamble...idx].permutation(2).none? { |perm| perm.sum == num }
    end
  end

  def sum_contiguous_range(goal)
    range = find_contiguous_range(goal)
    range.min + range.max
  end

  def find_contiguous_range(sum)
    total = 0
    range = []

    numbers.each do |number|
      return range if total == sum

      until total + number <= sum
        first = range.shift
        total -= first
      end

      total += number
      range << number
    end
  end

  private

  def parse_input(input)
    input.split("\n").map(&:to_i)
  end
end
