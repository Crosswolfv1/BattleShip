class Game
    attr_reader :player_board,
                :computer_board,
                :computer

    def initialize(player_board, computer_board, computer)
        @player_board = player_board
        @computer_board = computer_board
        @computer = computer
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

    def place_player_ships(ship) #modified so it takes an input as @player_<ship> is an unknown variable
        puts @player_board.render(true) #so it was pushing a nil value into the test recommend create a for each
                                        #and have an array of ships with a default cruiser and submarine
                                        # for each |ship| comp_ship1 = ship.new(ship, ship.length) perhaps and push 
                                        #those inot a computer ship and playership array then another foreach ship player places
        #place the cruiser
        puts "Enter the coordinates you would like to place your cruiser (3 are needed):"
        input = gets.chomp.upcase.split
        until @player_board.valid_placement?(ship, input)
            puts "Invalid coordinates: Try again..."
            input = gets.chomp.upcase.split
        end
        @player_board.place(ship, input)

        #the below code is rendered irrelavent with the chnages to the above code

        #place submarine
        # puts @player_board.render(true)
        # puts "Enter the coordinates you would like to place your submarine (2 are needed):"
        # input = gets.chomp.upcase.split
        # until @player_board.valid_placement?(@player_submarine, input)
        #     puts "Invalid coordinates: Try again..."
        #     input = gets.chomp.upcase.split
        # end
        # @player_board.place(@player_submarine, input)

        puts "Player has placed their ships."
        puts @player_board.render(true)
    end

    # def computer_random_placement(ship)   #this is unneeded as the computer class already provides coordinates
    #     coordinates = []
      
    #     until @computer_board.valid_placement?(ship, coordinates)
    #         binding.pry
    #         coordinates << @computer.generate_random_coordinate
    #     end
    #     @computer_board.place(ship, coordinates)
    # end 

    def place_computer_ships(ship)  #refactored this function to use the computer methods to place its ships
        computer.place_ships_randomly(ship)  #recommend making it a foreach liek player placed  to place multiple ships from a ship array
        # cruiser2 = Ship.new("Cruiser", 3) 
        # computer_random_placement(cruiser2)
        # # computer_random_placement(submarine2)

        puts "I have placed my ships."
    end

    def setup_phase
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

    def player_turn(coordinate)
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
        puts @comp_board.render
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
        welcome_message
    end

end