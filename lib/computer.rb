class Computer

    attr_reader :board,
                :coordinates

    def initialize(board)
        @board = board
        @coordinates = []
    end

    def generate_coordinates(length)
        coordinates = []

        while coordinates.length != length
            coordinates.clear
            possible_rows = ("A"..(65+@board.size-1).chr).to_a.sample
            possible_cols = (1..@board.size).to_a.sample
            orientation = ["horizontal", "vertical"].sample
            if orientation =="horizontal"
                length.times do |i| 
                    col = possible_cols + i
                    if col <= @board.size
                        coordinates << "#{possible_rows}#{col}"
                    end
                end
            else orientation == "vertical"
                length.times do |o|
                    row = (possible_rows.ord + o).chr
                    if row <= (65+@board.size-1).chr
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

    def generate_random_coordinate
        rows = ("A"..(65+@board.size-1).chr).to_a
        cols = (1..@board.size).to_a
        "#{rows.sample}#{cols.sample}"
    end

    def fire_at_random(board)
        coordinate = generate_random_coordinate
        while board.cells[coordinate].fired_upon?
            coordinate = generate_random_coordinate
        end
        board.cells[coordinate].fire_upon
        board.cells[coordinate].render
        @coordinates << coordinate
        coordinate
    end
end