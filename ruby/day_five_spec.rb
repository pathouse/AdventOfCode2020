require 'pry'
require_relative './day_five'

RSpec.describe BoardingPass do
  describe '.import' do
    let(:seat_codes) do
      <<~LINES
        BFFFBBFRRR
        FFFBBBFRRR
        BBFFBBFRLL
      LINES
    end

    it 'correctly reads a collection of seat codes into boarding passes' do
      passes = BoardingPass.import(seat_codes)

      expect(passes[0].seat_id).to eq(567)
      expect(passes[1].seat_id).to eq(119)
      expect(passes[2].seat_id).to eq(820)
    end
  end
end
