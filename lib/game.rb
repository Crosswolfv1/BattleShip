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

    def place_player_ships
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        puts @player_board.render(true)

        #place the cruiser
        puts "Enter the coordinates you would like to place your cruiser (3 are needed):"
        input = gets.chomp.upcase.split
        until @player_board.valid_placement?(cruiser, input)
            puts "Invalid coordinates: Try again..."
            input = gets.chomp.upcase.split
        end
        @player_board.place(cruiser, input)

        #place submarine
        puts @player_board.render(true)
        puts "Enter the coordinates you would like to place your submarine (2 are needed):"
        input = gets.chomp.upcase.split
        until @player_board.valid_placement?(submarine, input)
            puts "Invalid coordinates: Try again..."
            input = gets.chomp.upcase.split
        end
        @player_board.place(submarine, input)

        puts "Player has placed their ships."
        puts @player_board.render(true)
    end

    def computer_random_placement(ship)
        coordinates = @computer.generate_random_coordinate(ship)
        until @computer_board.valid_placement?(ship, coordinates)
            coordinates = @computer.generate_random_coordinate(ship)
        end
        @computer_board.place(ship, coordinates)
    end 

    def place_computer_ships
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        computer_random_placement(cruiser)
        computer_random_placement(submarine)

        puts "I have placed my ships."
    end
end