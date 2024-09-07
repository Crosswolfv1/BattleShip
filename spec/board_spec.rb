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
        @board.valid_placement?(@cruiser, ["A1", "A2"])
        @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
        end

        it 'coords are consecutive' do
            @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
            @board.valid_placement?(@submarine, ["A1", "C1"])
            @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
            @board.valid_placement?(@submarine, ["C1", "B1"])
        end

        it 'coords are NOT diagonal' do
            @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
            @board.valid_placement?(@submarine, ["C2", "D3"])
        end

        it 'can be valid' do
            @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
            @board.valid_placement?(@submarine, ["A1", "A2"])
        end
    end

end