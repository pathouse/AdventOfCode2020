require_relative './day_eleven'

RSpec.describe GameOfSeats do

  let(:input) do
    <<~LINES
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
    LINES
  end

  it 'simulates the game of seats' do
    game = GameOfSeats.new(input)
    expect(game.simulate).to eq(37)
  end

  let(:input_2) do
    <<~LINES
.##.##.
#.#.#.#
##...##
...L...
##...##
#.#.#.#
.##.##.
    LINES
  end

  it 'counts in a direction' do
    game = GameOfSeats.new(input_2)
    expect(game.count_visible_occupied([3,3])).to eq(0)
  end

  let(:input_3) do
    <<~LINES
.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....
    LINES
  end

  it 'counts in a direction' do
    game = GameOfSeats.new(input_3)
    expect(game.count_visible_occupied([4, 3])).to eq(8)
  end

  let(:input_4) do
    <<~LINES
.............
.L.L.#.#.#.#.
.............
    LINES
  end

  it 'counts in a direction' do
    game = GameOfSeats.new(input_4)
    expect(game.count_visible_occupied([1, 1])).to eq(0)
  end

  it 'simulates game of seats v2' do
    game = GameOfSeats.new(input)
    expect(game.simulate_v2).to eq(26)
  end
end
