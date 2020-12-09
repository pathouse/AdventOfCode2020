class Cipher
  attr_reader :numbers

  def initialize(input)
    @numbers = parse_input(input)
  end

  def first_invalid_number(preamble)
    numbers.each_with_index do |num, idx|
      next if idx < preamble

      return num if numbers[idx - preamble...idx].permutation(2).none? { |p| p.sum == num }
    end
  end

  def contiguous_range_min_max_sum(preamble)
    sum = first_invalid_number(preamble)
    range = find_contiguous_range(sum)
    range.min + range.max
  end

  private

  def parse_input(input)
    input.split("\n").map(&:to_i)
  end

  def find_contiguous_range(sum)
    numbers.each_with_index do |first_number, idx|
      range = complete_range(idx, first_number, sum)
      next if range.nil?

      return range
    end
  end

  def complete_range(idx, first_number, sum)
    range = [first_number]
    numbers[idx + 1..].each do |next_number|
      range << next_number
      return range if range.sum == sum
      return nil if range.sum > sum
    end
  end
end
