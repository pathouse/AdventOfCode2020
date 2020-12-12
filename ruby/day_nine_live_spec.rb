require_relative './day_nine_live'

RSpec.describe Cypher do
  let(:input) do
    <<~LINES
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    LINES
  end

  it 'finds the first invalid number given some preamble length' do
    cypher = Cypher.new(input)
    expect(cypher.find_first_invalid_number(5)).to eq(127)
  end

  it 'finds the sum of the range' do
    cypher = Cypher.new(input)
    goal = cypher.find_first_invalid_number(5)
    expect(cypher.sum_contiguous_range(goal)).to eq(62)
  end
end
