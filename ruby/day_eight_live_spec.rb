require_relative './day_eight_live'

RSpec.describe Program do
  let(:input) do
    <<~LINES
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    LINES
  end

  it 'returns the accumulator right before the loop begins' do
    fixer = ProgramFixer.new(input)
    prog = Program.new(fixer.instructions)
    expect(prog.run[:acc]).to eq(5)
  end

  it 'fixes the program and returns accumulator before it halts' do
    fixer = ProgramFixer.new(input)
    expect(fixer.run).to eq(8)
  end
end
