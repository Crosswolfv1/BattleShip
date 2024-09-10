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
    
    
end