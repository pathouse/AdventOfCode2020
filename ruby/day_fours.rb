class Passport
  def self.import(input)
    input.split("\n\n").map do |raw_pass|
      new(raw_pass.split(/\s/).map { |pair| pair.split(':') }.to_h)
    end
  end

  FIELDS = [
    { name: 'byr', required: { type: :range, gteq: 1920, lteq: 2002 } },
    { name: 'iyr', required: { type: :range, gteq: 2010, lteq: 2020 } },
    { name: 'eyr', required: { type: :range, gteq: 2020, lteq: 2030 } },
    {
      name: 'hgt', required: {
        type: :range_per_unit,
        'cm' => { gteq: 150, lteq: 193 },
        'in' => { gteq: 59, lteq: 76 }
      }
    },
    { name: 'hcl', required: { type: :hexcode } },
    { name: 'ecl', required: { type: :set, set: %w[amb blu brn gry grn hzl oth] } },
    { name: 'pid', required: { type: :digit_count, digits: 9 } },
    { name: 'cid', required: false }
  ].freeze

  def self.required_fields
    FIELDS.select { |f| f[:required] }
  end

  attr_reader :attrs

  def initialize(attrs)
    @attrs = attrs
  end

  def valid_by_presence?
    self.class.required_fields.all? do |f|
      attrs.fetch(f[:name], false)
    end
  end

  def valid_by_content?
    self.class.required_fields.all? do |f|
      value = attrs.fetch(f[:name], false)
      return value unless value

      validate_with_rules(value, f[:required])
    end
  end

  private

  def validate_with_rules(value, rule)
    case rule[:type]
    when :range
      validate_range(value, rule)
    when :range_per_unit
      validate_range_per_unit(value, rule)
    when :hexcode
      validate_hexcode(value)
    when :set
      validate_set(value, rule)
    when :digit_count
      validate_digit_count(value, rule)
    else
      raise "Unknown validation rule: #{rule[:type]}"
    end
  end

  def validate_range(value, rule)
    value.to_i >= rule[:gteq] && value.to_i <= rule[:lteq]
  end

  def validate_range_per_unit(str, rule)
    match = str.match(/(\d+)(cm|in)/)
    return false if match.nil?

    value = match[1].to_i
    unit = match[2]

    range = rule[unit]
    validate_range(value, range)
  end

  def validate_hexcode(value)
    value.match?(/^#[0-9a-f]{6}/)
  end

  def validate_set(value, rule)
    rule[:set].include?(value)
  end

  def validate_digit_count(value, rule)
    value.match?(/^\d{#{rule[:digits]}}$/)
  end
end
