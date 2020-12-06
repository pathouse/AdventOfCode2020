require_relative './day_six'

RSpec.describe QuizCounter do
  describe '#sum_uniq_answers' do
    let(:grouped_quizzes) do
      <<~LINES
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
      LINES
    end

    it 'sums the number of uniq answers per group' do
      expect(QuizCounter.new(grouped_quizzes).sum_uniq_answers).to eq(11)
    end

    it 'sums the number of questions everyone answered per group' do
      expect(QuizCounter.new(grouped_quizzes).sum_everyone_answers).to eq(6)
    end
  end
end
