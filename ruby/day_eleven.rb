require 'pry'
# frozen_string_literal: true

class GameOfSeats
  EMPTY = 'L'
  OCCUPIED = '#'
  FLOOR = '.'

  def initialize(input)
    @grid = parse_input(input)
  end

  def simulate
    changes = calculate_changes
    until changes.empty?
      apply_changes(changes)
      changes = calculate_changes
    end

    count(OCCUPIED)
  end

  def simulate_v2
    changes = calculate_changes_v2
    until changes.empty?
      apply_changes(changes)

      changes = calculate_changes_v2
    end

    count(OCCUPIED)
  end

  def count(state)
    @grid.sum do |row|
      row.count do |seat|
        seat == state
      end
    end
  end

  def count_visible_occupied(from_point)
    directions = [
      ->(point) { [point.first - 1, point.last - 1] },
      ->(point) { [point.first - 1, point.last] },
      ->(point) { [point.first - 1, point.last + 1] },
      ->(point) { [point.first, point.last - 1] },
      ->(point) { [point.first, point.last + 1] },
      ->(point) { [point.first + 1, point.last - 1] },
      ->(point) { [point.first + 1, point.last] },
      ->(point) { [point.first + 1, point.last + 1] }
    ]

    directions.sum do |dir|
      count_in_direction(dir.call(from_point), dir)
    end
  end

  private

  def apply_changes(changes)
    changes.each do |(x, y, state)|
      @grid[x][y] = state
    end
  end

  def calculate_changes
    changes = []

    @grid.each_with_index do |row, x|
      row.each_with_index do |point, y|
        case point
        when EMPTY
          changes << [x, y, OCCUPIED] if count_adjacent(x, y, OCCUPIED).zero?
        when OCCUPIED
          changes << [x, y, EMPTY] if count_adjacent(x, y, OCCUPIED) >= 4
        end
      end
    end

    changes
  end

  def calculate_changes_v2
    changes = []

    @grid.each_with_index do |row, x|
      row.each_with_index do |point, y|
        case point
        when EMPTY
          changes << [x, y, OCCUPIED] if count_visible_occupied([x, y]).zero?
        when OCCUPIED
          changes << [x, y, EMPTY] if count_visible_occupied([x, y]) >= 5
        end
      end
    end

    changes
  end

  def count_in_direction(point, dir)
    return 0 if point.any? { |coord| coord.negative? }

    if @grid[point.first].nil? || @grid[point.first][point.last].nil? || @grid[point.first][point.last] == EMPTY
      0
    elsif @grid[point.first][point.last] == OCCUPIED
      1
    else
      count_in_direction(dir.call(point), dir)
    end
  end

  def count_adjacent(x, y, val)
    adjacent_points = [
      [x - 1, y - 1],
      [x - 1, y],
      [x - 1, y + 1],
      [x, y - 1],
      [x, y + 1],
      [x + 1, y - 1],
      [x + 1, y],
      [x + 1, y + 1]
    ]

    adjacent_points
      .select { |p| p.all? { |point| point >= 0 } }
      .count { |(x1, y1)| @grid.fetch(x1, []).fetch(y1, nil) == val }
  end

  def parse_input(input)
    input.split("\n").map { |line| line.split('') }
  end
end
