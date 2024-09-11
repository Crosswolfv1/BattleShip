require './spec/spec_helper'

RSpec.describe Board do
    before (:each) do   
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end
    
    it '#makes a board' do
        expect(@board).to be_an_instance_of(Board)
    end

    it '#board contains cells' do
        expect(@board.cells.count).to eq(16)
    end

    it '#has a coordinate' do
        expect(@board.cells.keys[0]).to eq("A1")
        expect(@board.cells.keys[1]).to eq("A2")
        expect(@board.cells.keys[2]).to eq("A3")
    end

    it '#valid_coordinate?' do
        expect(@board.valid_coordinate?("A1")).to eq true
        expect(@board.valid_coordinate?("A20")).to eq false
        expect(@board.valid_coordinate?("B2")).to eq true
        expect(@board.valid_coordinate?("C3")).to eq true
        expect(@board.valid_coordinate?("D4")).to eq true
        expect(@board.valid_coordinate?("D5")).to eq false
    end

    describe '#valid_placement?' do
        it 'provided num of coords equal to ship length' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
        
        end

        it 'coords are consecutive' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
        end

        it 'coords are NOT diagonal' do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
        end

        it 'can be valid' do
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
        end
    end

    describe '#place' do
        it 'places ships' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            cell_1 = @board.cells["A1"]
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["A3"]
            
            expect(cell_1.ship).to be(@cruiser)
            expect(cell_2.ship).to be(@cruiser)
            expect(cell_3.ship).to be(@cruiser)
            expect(cell_1.ship == cell_2.ship).to eq(true)
        end

        it 'fails to place ship do to incorrect cells' do
            @board.place(@cruiser, ["A1", "A2", "B4"])
            cell_1 = @board.cells["A1"]
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["B4"]

            expect(cell_1.ship).to be(nil)
            expect(cell_2.ship).to be(nil)
            expect(cell_3.ship).to be (nil)
        end

        it 'fails to place ship when ship is already placed' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            cell_1 = @board.cells["A1"]
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["A3"]
            cell_4 = @board.cells["B1"]

            @board.place(@submarine, ["A1", "B1"])
            expect(cell_1.ship).to eq(@cruiser)
            expect(cell_4.ship).to be nil
        end

    end

    describe "#render" do
        it 'can show a board' do
            expect(@board.render).to eq("  1\t2\t3\t4\nA .\t.\t.\t. \nB .\t.\t.\t. \nC .\t.\t.\t. \nD .\t.\t.\t. \n")
        end

        it 'can show a board with ships shown' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            expect(@board.render(true)).to eq("  1\t2\t3\t4\nA S\tS\tS\t. \nB .\t.\t.\t. \nC .\t.\t.\t. \nD .\t.\t.\t. \n")
        end

        it "wont show a ship w/o true" do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            expect(@board.render).to eq("  1\t2\t3\t4\nA .\t.\t.\t. \nB .\t.\t.\t. \nC .\t.\t.\t. \nD .\t.\t.\t. \n")
        end
    end

    describe 'board can be variable sizes' do
        it 'makes a default of a 4x4' do
            expect(@board.cells.count).to eq(16)
        end

        it 'can make a board 10*10' do
            @board2 = Board.new(10)
            expect(@board2.cells.count).to eq(100)
        end
    end
end