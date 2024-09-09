require './spec/spec_helper'

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
answer = gets.chomp.downcase
shots = []
# if answer == 'p'
#     break run the game
# elsif answer == 'q'
#     break quit the game
# else
#     puts "invalid input"
#     loop to top
# end

@comp_board = Board.new
@player_board = Board.new

@cruiser = Ship.new("Cruiser", 3)
@submarine = Ship.new("Submarine", 2)

@computer = Computer.new(@comp_board)

@computer.place_ships_randomly(@cruiser)
@computer.place_ships_randomly(@submarine)
puts "I have laid out my ships.\nYou now need to lay out your ships.\nthe #{@cruiser.name} is #{@cruiser.length} units long."
puts @player_board.render(true)
loop do 
    puts "Enter the squares for the #{@cruiser.name} (#{@cruiser.length} spaces):"
    coordinates = gets.chomp.split(" ")
    if @player_board.valid_placement?(@cruiser, coordinates) == true
        @player_board.place(@cruiser, coordinates)
       break
    else
        puts "invalid coordinates please try again" 
    end
end

puts @player_board.render(true)
loop do 
    puts "Enter the squares for the #{@submarine.name} (#{@submarine.length} spaces):"
    coordinates = gets.chomp.split(" ")
    if @player_board.valid_placement?(@submarine, coordinates) == true
        @player_board.place(@submarine, coordinates)
       break
    else
        puts "invalid coordinates please try again" 
    end
end

###while computer ships or playerships != sunk
puts "=============COMPUTER BOARD============="
puts @comp_board.render
puts "==============PLAYER BOARD=============="
puts @player_board.render(true)

puts "Enter the coordinate for your shot:"
coordinate = gets.chomp
if @comp_board.valid_coordinate?(coordinate) && @comp_board.cells[coordinate].fired_upon? == false
    @comp_board.cells[coordinate].fire_upon
    shots << @comp_board.cells[coordinate]
else
    puts "Invalid coordinate" #loop to 46
end

@computer.fire_at_random(@player_board)
player_last_shot = shots.last
computer_last_shot = @computer.coordinates.last
puts "You last shot on #{player_last_shot.coordinate} was a #{@comp_board.cells[player_last_shot.coordinate].render}"
puts "My last shot on #{computer_last_shot} was a #{@player_board.cells[computer_last_shot].render}"


#when player ships / computer ships health = 0
if playership health 0
    puts "you lose!"
else
    puts "You win!"
end
puts "play again?" #loop to 3 puts "Welcome to BATTLESHIP"
