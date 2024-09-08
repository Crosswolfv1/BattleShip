class Computer

    attr_reader :board

    def initialize(board)
        @board = board
    end

    def generate_coordinates(length)
        coordinates = []

        while coordinates.length != length
            coordinates.clear
            possible_rows = ("A".."D").to_a.sample
            possible_cols = (1..4).to_a.sample
            orientation = ["horizontal", "vertical"].sample
            if orientation =="horizontal"
                length.times do |i| 
                    col = possible_cols + i
                    if col <= 4
                        coordinates << "#{possible_rows}#{col}"
                    end
                end
            else orientation == "vertical"
                length.times do |o|
                    row = (possible_rows.ord + o).chr
                    if row <= "D"
                        coordinates << "#{row}#{possible_cols}"
                    end
                end
            end
        end
        coordinates
    end


    def place_ships_randomly(ship)
        coordinates =[]

        until @board.valid_placement?(ship, coordinates)
            coordinates = generate_coordinates(ship.length)
        end
       
        @board.place(ship, coordinates)
    end
end