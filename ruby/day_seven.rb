class RelationDescription
  attr_reader :info

  def initialize(str)
    @info = parse_description(str)
  end

  private

  def parse_description(str)
    caps = str.match(/^(?<outer>[\w\s]+) bags contain (?<inner>.*)/).named_captures
    outer = caps['outer']
    inner = caps['inner']

    inners = parse_inner(inner)

    inners.compact.map do |color, count|
      { outer: outer, inner: color, count: count }
    end
  end

  def parse_inner(str)
    return [] if str == 'no other bags.'

    str.scan(/(\d+) ([a-z\s]+) bags?/m).each_with_object({}) do |(count, color), hsh|
      hsh[color] = count.to_i
    end
  end
end

class BagGraph
  def self.build(rel_descriptions)
    new.tap do |bag_graph|
      rel_descriptions.each do |desc|
        rel = RelationDescription.new(desc)
        rel.info.each do |relation|
          bag_graph.add_relationship(relation[:outer], relation[:inner], relation[:count])
        end
      end
    end
  end

  def initialize
    @nodes = {}
  end

  def add_relationship(outer, inner, count)
    outer_color = @nodes[outer] ||= Color.new(outer)
    inner_color = @nodes[inner] ||= Color.new(inner)

    rel = Relationship.new(outer, inner, count)

    outer_color.add_relationship(rel)
    inner_color.add_relationship(rel)
  end

  def all_parents(color)
    color = @nodes[color]
    return [] if color.parents.empty?

    color.parents + color.parents.flat_map { |c| all_parents(c) }
  end

  def count_children(color)
    color = @nodes[color]
    return 1 if color.children.empty?

    1 + color.children.sum { |child| child.count * count_children(child.inner) }
  end
end

class Relationship
  attr_reader :outer, :inner, :count

  def initialize(outer, inner, count)
    @outer = outer
    @inner = inner
    @count = count
  end
end

class Color
  attr_reader :name

  def initialize(name)
    @name = name
    @relationships = []
  end

  def add_relationship(rel)
    @relationships << rel
  end

  def parents
    @relationships.select { |rel| rel.inner == name }.map(&:outer)
  end

  def children
    @relationships.select { |rel| rel.outer == name }
  end
end
