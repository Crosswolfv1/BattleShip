class Board

    attr_reader :cells

    def initialize# no argument needed
    @cells = create_cell #create the cell
    end

    def create_cell# we need to create the board and that requires create_cells 4x4
        cells = {} # makes a Hash
        ("A".."D").each do |row|# this goes A->D in a row <--->
            (1..4).each do |col|# this goes 1->4 in a column ^----v
                coordinate = "#{row}#{col}"# we will give what the coordinate is to return our cell
                cells[coordinate] = Cell.new(coordinate)
            end
        end
        cells
    end

    def valid_coordinate?(coordinate)
        @cells.keys.include?(coordinate)        
    end

    def valid_placement?(ship, coordinates)

        return false unless coordinates.count == ship.length
        return false unless coordinates.all? { |coordinate| @cells[coordinate].empty? }

         coverted_coordinates = coordinates.map do |coordinate|
            [coordinate[0].ord, coordinate[1].to_i]
            end
            coverted_coordinates.each_cons(2).all? {|(row1, col1), (row2, col2)|
                if row1 == row2
                col2 == col1 + 1
                elsif col1 == col2
                row2 == row1 + 1
                else
                false
            end}
    end

    def place(ship, coordinates)
        if valid_placement?(ship, coordinates)
            coordinates.each do |coordinate|
                cell = @cells[coordinate]
                cell.place_ship(ship) if cell && cell.empty? 
            end
        end
    end

    def render(unhidden = false)
        output = "  1 2 3 4 \n"
        rows = ("A".."D").map do |row|
            contents = (1..4).map do |col|
                coordinate = "#{row}#{col}"
                @cells[coordinate].render(unhidden)
            end.join(" ")
        "#{row} #{contents} \n"
        end
        output + rows.join
    end
end