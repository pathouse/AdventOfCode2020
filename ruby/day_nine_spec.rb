require_relative './day_nine'

RSpec.describe Cipher do
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

  it 'returns the first invalid number' do
    expect(Cipher.new(input).first_invalid_number(5)).to eq(127)
  end

  it 'returns min max sum of contiguous range that adds up to first invalid number' do
    expect(Cipher.new(input).contiguous_range_min_max_sum(5)).to eq(62)
  end
end
