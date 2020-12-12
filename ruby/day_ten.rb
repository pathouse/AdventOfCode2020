class AdapterChain
  attr_reader :adapters

  def initialize(input)
    @adapters = input.split("\n").map(&:to_i).sort
    @adapters.unshift(0)
    @adapters.push(@adapters.last + 3)
  end

  def product_of_diffs
    diffs[1] * diffs[3]
  end

  def count_paths(adapter = adapters[0], idx = 0, paths = {})
    return paths[adapter] if paths[adapter]

    following_idx = (idx + 1...idx + 4).select { |i| adapters[i] && adapters[i] <= adapter + 3 }
    return paths[adapter] = 1 if following_idx.empty?

    paths[adapter] = following_idx.map { |i| count_paths(adapters[i], i, paths) }.sum
  end

  private

  def diffs
    @diffs ||=
      adapters.each_with_object({}).with_index do |(adapter, hsh), idx|
        unless idx.zero?
          diff = adapter - adapters[idx - 1]
          hsh[diff] ||= 0
          hsh[diff] += 1
        end

        hsh
      end
  end
end
