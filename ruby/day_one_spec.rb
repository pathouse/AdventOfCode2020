require_relative './day_one'

RSpec.describe DayOne do
  describe '#part_one' do
    let(:input) do
      <<-LINES
        1721
        979
        366
        299
        675
        1456
      LINES
    end

    it 'finds product of 2 entries to sum to 2020' do
      service = DayOne.new(input)
      expect(service.product_of_entries(2, 2020)).to eq(514_579)
    end

    it 'finds product of 3 entries that sum to 2020' do
      service = DayOne.new(input)
      expect(service.product_of_entries(3, 2020)).to eq(241_861_950)
    end
  end
end
