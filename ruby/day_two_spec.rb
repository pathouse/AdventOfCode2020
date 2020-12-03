require_relative './day_two'

RSpec.describe PasswordChecker do
  describe '#count_valid' do
    let(:input) do
      <<-LINES
        1-3 a: abcde
        1-3 b: cdefg
        2-9 c: ccccccccc
      LINES
    end

    it 'counts the number of valid passwords using the :count validation strategy' do
      checker = PasswordChecker.new(input)
      expect(checker.count_valid(:count)).to eq(2)
    end

    it 'counts the number of valid passwords using the :position validation strategy' do
      checker = PasswordChecker.new(input)
      expect(checker.count_valid(:position)).to eq(1)
    end
  end
end
