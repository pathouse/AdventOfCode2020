require_relative './day_three'

RSpec.describe TobogganMap do
  describe '#count_trees' do
    let(:input) do
      <<-LINES
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
      LINES
    end

    let(:slopes) do
      [
        { right: 1, down: 1 },
        { right: 3, down: 1 },
        { right: 5, down: 1 },
        { right: 7, down: 1 },
        { right: 1, down: 2 }
      ]
    end

    it 'counts the number of trees encountered' do
      map = TobogganMap.new(input)
      expect(map.count_trees(right: 3, down: 1)).to eq(7)
    end

    it 'calculates the product of many slopes' do
      map = TobogganMap.new(input)
      expect(map.product_of_slopes(slopes)).to eq(336)
    end
  end
end
