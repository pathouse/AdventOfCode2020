class DayOne
  attr_reader :nums

  def initialize(input)
    @nums = parse_input(input)
  end

  def product_of_entries(num_entries, sum)
    nums
      .permutation(num_entries)
      .find { |perm| perm.sum == sum }
      .reduce(1, &:*)
  end

  private

  def parse_input(input)
    input.split("\n").map(&:to_i)
  end
end
