class TobogganMap
  attr_reader :rows, :col_width

  def initialize(input)
    @rows = parse_input(input)
    @col_width = @rows.first.count
  end

  def product_of_slopes(slopes)
    slopes.reduce(1) do |acc, s|
      count_trees(right: s[:right], down: s[:down]) * acc
    end
  end

  def count_trees(right:, down:)
    current_row = 0
    current_col = 0
    trees = 0

    until current_row > rows.count - 1
      trees += 1 if rows[current_row][current_col]

      current_row += down
      current_col = (current_col + right) % col_width
    end

    trees
  end

  private

  def parse_input(str)
    str.split("\n").map do |line|
      line.strip.split('').map { |char| char == '.' ? false : true }
    end
  end
end
