require 'spec_helper'

RSpec describe Game do
    before(:each) do
        @board = Board.new
        @player_board = Board.new
        @computer = Computer.new(@board)
        @game = Game.new(@player_board, @board, @computer)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
        @computer_cruiser = Ship.new("Cruiser", 3)
        @computer_submarine = Ship.new("Submarine", 2)
    end

    describe 'starts a game' do 
        it 'exists' do
            expect(@game).to be_an_instance_of(Game)
            expect(@game.player_board).to eq(@player_board)
            expect(@game.computer_board).to eq(@computer_board)
            expect(@game.computer).to eq(@computer)
        end
    end

    describe 'player turn' do
        it "fires upon a valid coordinate on the computer's board" do
            @computer_board.place(@computer_cruiser, ["A1", "A2", "A3"])
            expect(@computer_board.cells["A1"].fired_upon?).to be false
      
            @game.player_turn("A1")
      
            expect(@computer_board.cells["A1"].fired_upon?).to be true
            expect(@computer_board.cells["A1"].render).to eq("H")
        end
    end

    describe '#computer_turn' do
        it "fires at a valid random coordinate on the player's board" do
            @player_board.place(@player_cruiser, ["A1", "A2", "A3"])
  
            initial_fired_upon = @player_board.cells.values.count { |cell| cell.fired_upon? }
            @game.computer_turn
  
            final_fired_upon = @player_board.cells.values.count { |cell| cell.fired_upon? }
            expect(final_fired_upon).to eq(initial_fired_upon + 1)
        end
    end

    describe "#game_over?" do
        it "ends the game when all of player's ships are sunk" do
            @player_board.place(@player_cruiser, ["A1", "A2", "A3"])
            @player_board.place(@player_submarine, ["B1", "B2"])

            @player_board.cells["A1"].fire_upon
            @player_board.cells["A2"].fire_upon
            @player_board.cells["A3"].fire_upon
            @player_board.cells["B1"].fire_upon
            @player_board.cells["B2"].fire_upon

            expect(@game.all_ships_sunk?(@player_board)).to be true
            expect(@game.game_over?).to be true
        end

        it "ends the game when all of computer's ships are sunk" do
            @computer_board.place(@computer_cruiser, ["A1", "A2", "A3"])
            @computer_board.place(@computer_submarine, ["B1", "B2"])
  
            @computer_board.cells["A1"].fire_upon
            @computer_board.cells["A2"].fire_upon
            @computer_board.cells["A3"].fire_upon
            @computer_board.cells["B1"].fire_upon
            @computer_board.cells["B2"].fire_upon
  
            expect(@game.all_ships_sunk?(@computer_board)).to be true
            expect(@game.game_over?).to be true
        end
    end
end