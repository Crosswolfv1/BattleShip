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

        coordinates.map do |coordinate|
            [coordinate[0].ord,
            coordinate[1].to_i]
        end.each_cons(2).all? {|(letter1, num1), (letter2, num2)|
        if letter1 == letter2
            num2 == num1 + 1
        elsif num1 == num2
            letter2 == letter1 + 1
        else
            false
        end}
        # ship.length == coordinates.count
    end

end