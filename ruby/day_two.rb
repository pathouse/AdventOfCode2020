class PasswordPolicy
  attr_reader :range, :letter, :strat

  def initialize(range, letter)
    @range = parse_range(range)
    @letter = letter
  end

  def valid?(password, validation_strategy)
    case validation_strategy
    when :count
      occurrences = password.count(letter)
      occurrences >= range.first && occurrences <= range.last
    when :position
      chars = range.map { |n| password[n - 1] }

      return false if chars.none? { |c| c == letter }
      return false if chars.all? { |c| c == letter }

      chars.any? { |c| c == letter }
    else
      raise "Unknown validation strategy: #{validation_strategy}"
    end
  end

  private

  def parse_range(str)
    str.split('-').map(&:to_i)
  end
end

class PasswordChecker
  attr_reader :policies_and_passwords

  def initialize(input)
    @policies_and_passwords = parse_input(input)
  end

  def count_valid(validation_strategy)
    policies_and_passwords.sum do |(policy, password)|
      policy.valid?(password, validation_strategy) ? 1 : 0
    end
  end

  private

  def parse_input(input)
    input.split("\n").map do |line|
      match = line.match(/(\d+-\d+)\s([a-z]):\s([a-z]+)/)
      raise "Regex match failed on: #{line}" if match.nil?

      [
        PasswordPolicy.new(match[1], match[2]),
        match[3]
      ]
    end
  end
end
