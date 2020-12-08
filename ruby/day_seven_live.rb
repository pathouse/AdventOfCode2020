class RuleParser
  attr_reader :edges

  def initialize(rule)
    @edges = parse_rule(rule)
  end

  private

  def parse_rule(rule)
    caps = rule.match(/^(?<outer>[\w\s]+) bags contain (?<inner>.*)/).named_captures
    outer = caps['outer']
    inner = caps['inner']

    parse_inner(inner).map do |edge|
      edge.merge(outer: outer)
    end
  end

  def parse_inner(inner)
    return [] if inner == 'no other bags.'

    inner.scan(/(\d+) ([\w\s]+) bags?/).map do |(count, color)|
      { inner: color, count: count.to_i }
    end
  end
end

class Graph
  def self.build(input)
    new.tap do |graph|
      input.split("\n").each do |rule|
        RuleParser.new(rule).edges.each do |edge|
          graph.add_edge(edge[:outer], edge[:inner], edge[:count])
        end
      end
    end
  end

  def initialize
    @graph = {}
  end

  def add_edge(outer, inner, count)
    outer_bag = @graph[outer] ||= Bag.new(outer)
    inner_bag = @graph[inner] ||= Bag.new(inner)

    edge = Edge.new(outer, inner, count)

    outer_bag.add_edge(edge)
    inner_bag.add_edge(edge)
  end

  def all_outers(color)
    bag = @graph[color]
    return [] if bag.outers.empty?

    outer_names = bag.outers.map(&:outer)
    outer_names + outer_names.flat_map { |n| all_outers(n) }
  end

  def product_of_children(color)
    bag = @graph[color]
    return 1 if bag.inners.empty?


    1 + bag.inners.sum { |i| i.count * product_of_children(i.inner) }
  end
end

class Edge
  attr_reader :outer, :inner, :count

  def initialize(outer, inner, count)
    @outer = outer
    @inner = inner
    @count = count
  end
end

class Bag
  attr_reader :color

  def initialize(color)
    @color = color
    @edges = []
  end

  def add_edge(edge)
    @edges << edge
  end

  def outers
    @edges.select { |edge| edge.inner == color }
  end

  def inners
    @edges.select { |edge| edge.outer == color }
  end
end
