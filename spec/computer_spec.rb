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

    it '#generate_random_coordinate' do
        100.times do
            coordinate = @computer.generate_random_coordinate
            row = coordinate[0]
            col = coordinate[1..-1].to_i

            expect(("A".."D").to_a).to include(row)
            expect((1..4).to_a).to include(col)
        end
    end

    it '#fire_at_random fires at random coordinate' do
        coordinate = @computer.fire_at_random
        inital_shot_result = @computer.board.cells[coordinate].render
        expect(["M", "H", "X"]).to include(inital_shot_result)
    end

    it '#fire_at_random will not shoot same coordinate twice' do
        shots = []
        10.times do
            result = @computer.fire_at_random
            shots << result
        end
        expect(shots.uniq.length).to be(10)
    end

    it 'can sometimes hit' do
        @board.place(@cruiser, ['A1', 'A2', 'A3'])
        hits = []
        14.times do
            shots = @computer.fire_at_random
            hits << @computer.board.cells[shots].render
        end
        expect(hits).to include("H", "M")
    end
end