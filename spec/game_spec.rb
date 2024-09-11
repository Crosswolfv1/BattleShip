require 'spec_helper'

describe Game do  # Use `describe` here for the Game class
  before(:each) do
    allow($stdout).to receive(:puts)
    allow_any_instance_of(Game).to receive(:gets).and_return("4","n","A1 A2 A3", "B1 B2")
    @game = Game.new
    @game.setup_phase
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  describe 'starts a game' do 
    it 'exists' do
      expect(@game).to be_an_instance_of(Game)
    end
  end

  describe 'player places ships' do
    it 'prompts the player and places ships on the board' do
      expect(@game.player_board.cells["A1"].ship).to be_an_instance_of(Ship)
      expect(@game.player_board.cells["A2"].ship).to be_an_instance_of(Ship)
      expect(@game.player_board.cells["A3"].ship).to be_an_instance_of(Ship)
      expect(@game.player_board.cells["B1"].ship).to be_an_instance_of(Ship)
      expect(@game.player_board.cells["B2"].ship).to be_an_instance_of(Ship)
    end
  end

  describe 'computer places ships' do 
    it 'can place ships' do
      @game.place_computer_ships
      placed_cells = @game.computer_board.cells.values.select { |cell| !cell.empty? }

      placed_cells.each do |cell|
        expect(cell.ship).to be_an_instance_of(Ship)
      end
    end
  end

  describe 'player turn' do
    it "fires upon a valid coordinate on the computer's board" do
      placed_cells = @game.computer_board.cells.values.select { |cell| !cell.empty? }
      allow_any_instance_of(Game).to receive(:gets).and_return(placed_cells[0].coordinate)
      @game.player_turn

      expect(@game.computer_board.cells[placed_cells[0].coordinate].fired_upon?).to be true
      expect(@game.computer_board.cells[placed_cells[0].coordinate].render).to eq("H")
    end
  end

  describe 'computer turn' do
    it "fires at a valid random coordinate on the player's board" do
      @game.player_board.place(@player_cruiser, ["A1", "A2", "A3"])
      initial_fired_upon = @game.player_board.cells.values.count { |cell| cell.fired_upon? }
      @game.computer_turn
      final_fired_upon = @game.player_board.cells.values.count { |cell| cell.fired_upon? }

      expect(final_fired_upon).to eq(initial_fired_upon + 1)
    end
  end

  describe 'game_over?' do
    it "ends the game when all player's ships are sunk" do
      @game.player_board.place(@player_cruiser, ["A1", "A2", "A3"])
      @game.player_board.place(@player_submarine, ["B1", "B2"])

      @game.player_board.cells["A1"].fire_upon
      @game.player_board.cells["A2"].fire_upon
      @game.player_board.cells["A3"].fire_upon
      @game.player_board.cells["B1"].fire_upon
      @game.player_board.cells["B2"].fire_upon

      expect(@game.all_ships_sunk?(@game.player_board)).to be true
      expect(@game.game_over?).to be true
    end

    it "ends the game when all computer's ships are sunk" do
      @game.computer_board.place(@computer_cruiser, ["A1", "A2", "A3"])
      @game.computer_board.place(@computer_submarine, ["B1", "B2"])

      placed_cells = @game.computer_board.cells.values.select { |cell| !cell.empty? }

      placed_cells.each do |cell|
        cell.fire_upon
      end

      expect(@game.all_ships_sunk?(@game.computer_board)).to be true
      expect(@game.game_over?).to be true
    end
  end
end
