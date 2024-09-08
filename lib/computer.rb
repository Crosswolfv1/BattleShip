class Computer

    def initialize
        @board = Board.new
    end

    def generate_coordinates(length)
        possible_rows = ("A".."D").to_a.sample
        possible_cols = (1..4).to_a.sample
        coordinates = []

        while coordinates.length != length
            coordinates.clear
            orientation = ["horizontal", "vertical"].sample
            if orientation =="horizontal"
                length.times do |i| 
                    col = possible_cols
                    if col + i <= 4
                        coordinates << "#{possible_rows}#{col + i}"
                    end
                end
            else orientation == "vertical"
                length.times do |o|
                    row = possible_rows
                    if (row.ord + o).chr <= "D"
                        coordinates << "#{(row.ord + o).chr}#{possible_cols}"
                    end
                end
            end
        end
        coordinates
    end


    def place_ships(ship)
        @board.valid_placement?(ship, coordinates)
    end
end