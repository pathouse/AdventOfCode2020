require_relative './day_ten'

RSpec.describe AdapterChain do
  let(:input_2) do
    <<~LINES
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    LINES
  end

  let(:input) do
    <<~LINES
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    LINES
  end

  it 'calculates product of jolt differences' do
    chain = AdapterChain.new(input)
    expect(chain.product_of_diffs).to eq(220)
  end

  let(:another_input) do
    <<~LINES
    1
    2
    3
    4
    5
    6
    7
    LINES
  end

  it 'counts number of possible permutations' do
    chain = AdapterChain.new(input)
    expect(chain.count_paths).to eq(19208)
  end
end
