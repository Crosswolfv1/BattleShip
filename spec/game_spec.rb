require 'spec_helper'

RSpec describe Game do
    before(:each) do
        @board = Board.new
        @player_board = Board.new
        @computer = Computer.new(@board)
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @game = Game.new(@player_board, @board, @computer)

    end
    describe 'starts a game' do 
        it 'exists' do
            expect(@game).to be_an_instance_of(Game)
        end
    end

    describe '#setup' do
        xit 'prompts player to place ships' do #idk how to test this but pretend the codes exists and works
            @game.place_player_ships
        end

        it 'sets up computers ships' do
            @game.place_computer_ships
            placed_cells = @board.cells.values.select { |cell| !cell.empty? }
            expect(placed_cells.length).to eq(3)
    
            placed_cells.each do |cell|
            expect(cell.ship).to eq(@cruiser)
        end
    end

    describe '#display_boards' do #needs to display comp board first then play board true
        it 'can display boards' do
            @game.place_computer_ships
            @board.render
            #cant test player boards cause needs player input
        end
    end

    describe 'player turn' do
        xit 'has a turn' do
            #yeah pretend there is a test here but yeah just copy it from the runner the player shoots loop
        end
    end
    describe '#computer_turn' do
        it 'has a turn' do 
            @game.computer_turn
            coordinate = @computer.fire_at_random(@player_board)
            inital_shot_result = @player_board.cells[coordinate].render
            expect(["M", "H", "X"]).to include(inital_shot_result)
        end
    end
end