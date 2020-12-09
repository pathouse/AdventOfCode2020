Instruction = Struct.new(:operation, :arg)

class ProgramFixer
  attr_reader :instructions

  def initialize(input)
    @instructions = parse_input(input)
  end

  def run
    instructions.each_with_index do |instruction, idx|
      case instruction.operation
      when 'nop'
        next if instruction.arg <= 0

        instructions_copy = instructions.dup
        instructions_copy[idx] = Instruction.new('jmp', instruction.arg)
        result = Program.new(instructions_copy).run
        return result[:acc] if result[:reason] == :halt
      when 'jmp'
        next unless instruction.arg <= 0

        instructions_copy = instructions.dup
        instructions_copy[idx] = Instruction.new('nop', instruction.arg)
        result = Program.new(instructions_copy).run
        return result[:acc] if result[:reason] == :halt
      end
    end
    'No halt found'
  end

  private

  def parse_input(input)
    input.split("\n").map do |line|
      op, arg = line.strip.split(' ')
      Instruction.new(op, arg.to_i)
    end
  end
end

class Program
  attr_reader :instructions, :acc, :idx, :visits

  def initialize(instructions)
    @instructions = instructions
    @idx = 0
    @acc = 0
    @visits = []
  end

  def run
    return { acc: acc, reason: :loop } if visits.include?(idx)

    @visits << idx
    instruction = instructions[idx]
    return { acc: acc, reason: :halt } if instruction.nil?

    run_instruction(instruction)
    run
  end

  private

  def run_instruction(instruction)
    case instruction.operation
    when 'acc'
      @acc += instruction.arg
      @idx += 1
    when 'jmp'
      @idx += instruction.arg
    when 'nop'
      @idx += 1
    else
      raise "Unknown operation: #{instruction.operation}"
    end
  end
end
