Instruction = Struct.new(:operation, :arg)

class BootChecker
  def initialize(instructions)
    @instructions = parse_instructions(instructions)
  end

  def parse_instructions(str)
    str.chomp.split("\n").map do |i|
      op, arg = i.strip.split(' ')
      Instruction.new(op, arg.to_i)
    end
  end

  def loop_check
    BootCode.new(@instructions).run[:acc]
  end

  def halt_check
    @instructions.each_with_index do |inst, idx|
      case inst.operation
      when 'nop'
        instruct = @instructions.dup
        instruct[idx] = Instruction.new('jmp', inst.arg)
        result = BootCode.new(instruct).run
        return result[:acc] if result[:halted]
      when 'jmp'
        instruct = @instructions.dup
        instruct[idx] = Instruction.new('nop', inst.arg)
        result = BootCode.new(instruct).run
        return result[:acc] if result[:halted]
      end
    end
    'No halt found'
  end
end

class BootCode
  def initialize(instructions)
    @instructions = instructions
    @idx = 0
    @acc = 0
  end

  def run(visits = [])
    return { acc: @acc, halted: false } if visits.include?(@idx)

    visits << @idx
    inst = @instructions[@idx]
    return { acc: @acc, halted: true } if inst.nil?

    exec(inst.operation, inst.arg)
    run(visits)
  end

  private

  def exec(operation, arg)
    case operation
    when 'acc'
      @acc += arg
      @idx += 1
    when 'jmp'
      @idx += arg
    when 'nop'
      @idx += 1
    else
      raise "Unknown op: #{operation}"
    end
  end
end
