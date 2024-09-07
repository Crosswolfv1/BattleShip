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

end