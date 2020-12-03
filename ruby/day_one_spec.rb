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

    it 'multiplies together the two entries that sum to the desired amount' do
      service = DayOne.new(input)
      expect(service.product_of_entries(2, 2020)).to eq(514579)
    end

    it 'multiplies entries together' do
      service = DayOne.new(input)
      expect(service.product_of_entries(3, 2020)).to eq(241861950)
    end
  end
end
