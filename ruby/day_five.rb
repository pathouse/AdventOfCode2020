class BoardingPassList
  attr_reader :passes

  def initialize(input)
    @passes = input.split("\n").map do |line|
      BoardingPass.new(line)
    end
  end

  def seat_ids
    @seat_ids ||= passes.map(&:seat_id).sort
  end

  def find_seat_id
    seat_ids.each_with_index do |seat, idx|
      return seat + 1 if seat_ids[idx + 1] != seat + 1
    end
    return 'Failed to find missing seat'
  end
end

class BoardingPass
  ROWS = 127
  COLS = 7

  attr_reader :seat_code

  def initialize(seat_code)
    @seat_code = seat_code
  end

  def seat_id
    (seat_row * 8) + seat_col
  end

  def seat_col
    @seat_col ||= calculate_seat_col
  end

  def seat_row
    @seat_row ||= calculate_seat_row
  end

  private

  def calculate_seat_row
    row_search_str = seat_code[0..7].split('').map { |c| row_to_dir(c) }.reverse
    binary_search([0, ROWS], row_search_str)
  end

  def calculate_seat_col
    col_search_str = seat_code[7..].split('').map { |c| col_to_dir(c) }.reverse
    binary_search([0, COLS], col_search_str)
  end

  def binary_search(range, dirs)
    current_dir = dirs.pop

    if dirs.empty?
      current_dir == :lower ? range.first : range.last
    else
      front = [range.first, midpoint(range.first, range.last)]
      back = [midpoint(range.first, range.last) + 1, range.last]

      current_dir == :lower ? binary_search(front, dirs) : binary_search(back, dirs)
    end
  end

  def midpoint(low, high)
    low + ((high - low) / 2)
  end

  def row_to_dir(letter)
    letter == 'F' ? :lower : :upper
  end

  def col_to_dir(letter)
    letter == 'L' ? :lower : :upper
  end
end
