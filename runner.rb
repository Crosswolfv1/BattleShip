require './spec/spec_helper'
loop do
    game_over = false
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    answer = gets.chomp.downcase
    shots = []
    loop do
        if answer == 'p'
            break 
        elsif answer == 'q'
            exit
        else
            puts "invalid input"
        end
    end

    @comp_board = Board.new
    @player_board = Board.new

    @cruiser1 = Ship.new("Cruiser", 3)  #make unique
    @submarine1 = Ship.new("Submarine", 2) #make unique
    @cruiser2 = Ship.new("Cruiser", 3)  #make unique
    @submarine2 = Ship.new("Submarine", 2) #make unique

    @computer = Computer.new(@comp_board)

    @computer.place_ships_randomly(@cruiser1)
    @computer.place_ships_randomly(@submarine1)
    puts "I have laid out my ships.\nYou now need to lay out your ships.\nThe #{@cruiser2.name} is #{@cruiser2.length} units long."
    puts @player_board.render(true)
    loop do 
        puts "Enter the squares for the #{@cruiser2.name} (#{@cruiser2.length} spaces):"
        coordinates = gets.chomp.to_s.split(" ")
        if @player_board.valid_placement?(@cruiser2, coordinates) == true
            @player_board.place(@cruiser2, coordinates)
           break
        else
            puts "invalid coordinates please try again" 
        end
    end

    puts "The #{@submarine2.name} is #{@submarine2.length} units long."
    puts @player_board.render(true)
    loop do 
        puts "Enter the squares for the #{@submarine2.name} (#{@submarine2.length} spaces):"
        coordinates = gets.chomp.split(" ")
        if @player_board.valid_placement?(@submarine2, coordinates) == true
            @player_board.place(@submarine2, coordinates)
           break
        else
            puts "invalid coordinates please try again" 
        end
    end

    ###while computer ships or playerships != sunk
    while game_over == false do    
        puts "=============COMPUTER BOARD============="
        puts @comp_board.render
        puts "==============PLAYER BOARD=============="
        puts @player_board.render(true)
        loop do
            puts "Enter the coordinate for your shot:"
            coordinate = gets.chomp
            if @comp_board.valid_coordinate?(coordinate) && @comp_board.cells[coordinate].fired_upon? == false
                @comp_board.cells[coordinate].fire_upon
                shots << @comp_board.cells[coordinate]
                break
            else
                puts "Invalid coordinate"
            end
        end
        computer_last_shot = []
        player_last_shot= []
        @computer.fire_at_random(@player_board)
        player_last_shot << shots.last.coordinate
        computer_last_shot << @computer.coordinates.last
        puts "Your last shot on #{player_last_shot.last} was a #{@comp_board.cells[player_last_shot.last].render}"
        puts "My last shot on #{computer_last_shot.last} was a #{@player_board.cells[computer_last_shot.last].render}"
       

        player_placed_cells = @player_board.cells.values.select { |cell| !cell.empty? }
        comp_placed_cells = @comp_board.cells.values.select { |cell| !cell.empty? }

        if player_placed_cells.all? {|cell| cell.ship.sunk?} 
            puts "you lose!"
            game_over = true
            break
        elsif comp_placed_cells.all? {|cell| cell.ship.sunk?} 
            puts "You win!"
            game_over = true
            break
        end
    end
end