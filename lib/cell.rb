class Cell
    attr_reader :coordinate, 
                :ship, 
                :fired_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty? #tells if cell is empty
        @ship.nil?
    end

    def place_ship(ship) # places ship in cell
        @ship = ship
    end

    def fired_upon? # if fired upon it will come up false
        @fired_upon
    end

    def fire_upon
        @fired_upon = true #marks cell as fired upon
        @ship.hit if @ship # reduce ship health by 1
    end
end