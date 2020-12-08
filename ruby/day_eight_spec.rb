require_relative './day_eight'

RSpec.describe BootChecker do
  let(:instructions) do
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

  it 'detects the loop' do
    boot = BootChecker.new(instructions)
    expect(boot.loop_check).to eq(5)
  end

  it 'detects the halt' do
    boot = BootChecker.new(instructions)
    expect(boot.halt_check).to eq(8)
  end
end
