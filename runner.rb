require './spec/spec_helper'

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
answer = gets.chomp.downcase
shots = []
if answer == 'p'
    break run the game
elsif answer == 'q'
    break quit the game
else
    puts "invalid input"
    loop to top
end

@comp_board = Board.new
@player_board = Board.new

@cruiser = Ship.new("Cruiser", 3)
@submarine = Ship.new("Submarine", 2)

@computer = Computer.new(@comp_board)

@computer.place_ships_randomly(@cruiser)
@computer.place_ships_randomly(@submarine)
puts "I have laid out my ships.\nYou now need to lay out your ships.\nthe #{@cruiser.name} is #{@cruiser.length} units long."
puts @player_board.render(true)
puts "Enter the squares for the #{@cruiser.name} (#{@cruiser.length} spaces):"
coordinates = gets.chomp.to_a
if @player_board.valid_placement?(@cruiser, coordinates) == true
    @player_board.place(@cruiser, coordinates)
else
    "invalid coordinates please try again" #loop back to 27 @player_board.render(true)
end

puts @player_board.render(true)
puts "Enter the squares for the #{@submarine.name} (#{@submarine.length} spaces):"
coordinates = gets.chomp.to_a
if @player_board.valid_placement?(@submarine, coordinates) == true
    @player_board.place(@submarine, coordinates)
else
    "invalid coordinates please try again" #loop back to 36 @player_board.render(true)
end

###while computer ships or playerships != sunk
puts "=============COMPUTER BOARD============="
puts @computer_board.render
puts "==============PLAYER BOARD=============="
puts @player_board.render(true)

puts "Enter the coordinate for your shot:"
coordinate = gets.chomp.to_s
if @computer_board.valid_coordinate?(coordinate) && !@comp_board.cells[coordinate].fired_upon? == false
    @comp_board.cells[coordinate].fired_upon
    shots << @comp_board.cells[coordinate]
else
    puts "Invalid coordinate" #loop to 46
end

@computer.fire_at_random
player_last_shot = shots.last
computer_last_shot = @computer.coordinates.last
puts "You last shot on #{player_last_shot.coordinate} was a #{player_last_shot.render}"
puts "My last shot on #{computer_last_shot.coordinate} was a #{@computer_board.cells[computer_last_shot].render}"


#when player ships / computer ships health = 0
if playership health 0
    puts "you lose!"
else
    puts "You win!"
end
puts "play again?" #loop to 3 puts "Welcome to BATTLESHIP"
