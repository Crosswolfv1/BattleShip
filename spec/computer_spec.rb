require './spec/spec_helper'

RSpec.describe Computer do
    before(:each) do
    @board = Board.new
    @computer = Computer.new(@board)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    end

    it 'exists' do
        expect(@computer).to be_an_instance_of(Computer)
    end

    it '#generate_coordinates' do
        expect(@computer.generate_coordinates(3).count).to eq(3)
        expect(@computer.generate_coordinates(2).count).to eq(2)
    end

    it '#place_ships_randomly' do
        @computer.place_ships_randomly(@cruiser)

        placed_cells = @board.cells.values.select { |cell| !cell.empty? }
        expect(placed_cells.length).to eq(3)

        placed_cells.each do |cell|
        expect(cell.ship).to eq(@cruiser)
        end
    end
end