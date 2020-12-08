require_relative './day_seven_live'

RSpec.describe Graph do
  let(:rules) do
    <<~LINES
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    LINES
  end

  it 'can count all containing bags' do
    graph = Graph.build(rules)
    expect(graph.all_outers('shiny gold').uniq.count).to eq(4)
  end

  let(:rules_two) do
    <<~LINES
      shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.
    LINES
  end

  it 'can count the number of bags contained' do
    graph = Graph.build(rules_two)
    expect(graph.product_of_children('shiny gold') - 1).to eq(126)
  end
end
