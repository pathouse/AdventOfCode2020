class WindowCipher
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
    total = 0
    range = []

    numbers.each do |n|
      return range if total == sum

      until total + n <= sum
        first = range.shift
        total -= first
      end

      total += n
      range << n
    end
  end
end
