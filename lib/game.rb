class Game
    attr_reader :player_board,
                :computer_board,
                :computer,
                :player_ships,
                :computer_ships

    def initialize
    end
    
    def start
        welcome_message
        setup_phase
        game_loop
    end

    def welcome_message
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."
        answer = gets.chomp.downcase
            if answer == 'p'
                puts "Lets play!"
            elsif answer == 'q'
                puts "Bye Bye!"
                exit
            else
                puts "invalid input"
                welcome_message
            end
    end

    def place_player_ships 
        @player_ships.each do |ship|
        puts @player_board.render(true)
            puts "Enter the coordinates you would like to place your #{ship.name} (#{ship.length} are needed):"
            input = gets.chomp.upcase.split
            
            until @player_board.valid_placement?(ship, input)
                puts "Invalid coordinate: Try again."
                input = gets.chomp.upcase.split
            end

        @player_board.place(ship, input)
        end

        puts "Player has placed their ships."
        puts @player_board.render(true)
    end


    def place_computer_ships
        @computer_ships.each do |ship|
        computer.place_ships_randomly(ship)
        end
        
    end

    def setup_phase
        puts "Enter a number for the size of the board (min 4):"
        size = gets.chomp.to_i
        @player_board = Board.new(size)
        @computer_board = Board.new(size)
        @computer = Computer.new(@computer_board)
        @player_ships = [
            Ship.new("Cruiser", 3),
            Ship.new("Submarine", 2)
        ]
        @computer_ships = [
            Ship.new("Cruiser", 3),
            Ship.new("Submarine", 2)
        ]
        puts "I have placed my ships."
        puts "It's your turn to place ships."
        place_player_ships
        place_computer_ships
    end

    #main game loop
    def game_loop
        until game_over?
            player_turn
            break if game_over?

            computer_turn
            break if game_over?

            display_boards
        end

    end_game_message
    end

    def player_turn
        puts "It's your turn! Enter a coordinate to fire upon:"
        coordinate = gets.chomp.upcase
        until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
            puts "invalid coordinate or previously fired upon. Try again:"
            coordinate = gets.chomp.upcase
        end
        @computer_board.cells[coordinate].fire_upon

        puts "You fired at #{coordinate}. Result: #{@computer_board.cells[coordinate].render}"
    end

    def computer_turn
        puts "Computer's turn..."
        coordinate = @computer.fire_at_random(@player_board)
        puts "Computer fired at #{coordinate}. Result: #{@player_board.cells[coordinate].render}"
    end

    def display_boards
        puts "=============COMPUTER BOARD============="
        puts @computer_board.render
        puts "==============PLAYER BOARD=============="
        puts @player_board.render(true)
    end

    def all_ships_sunk?(board)
        board.cells.values.all? { |cell| cell.empty? || cell.ship.sunk? }
    end

    def game_over?
        all_ships_sunk?(@player_board) || all_ships_sunk?(@computer_board)
    end      

    def end_game_message
        if all_ships_sunk?(@player_board)
            puts "You lose! Better luck next time."
        else
            puts "You Win! GOOD JOB!"
        end
        start
    end

end
