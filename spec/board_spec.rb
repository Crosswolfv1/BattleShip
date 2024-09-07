require './spec/spec_helper'

RSpec.describe Board do
    before (:each) do   
        @board = Board.new
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

end