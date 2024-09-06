require './spec/spec_helper'

RSpec.describe Cell do
    before(:each) do
        @cell1 = Cell.new("A1")
        @cell2 = Cell.new("B1")
        @cell3 = Cell.new("A2")
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe '#initialize' do
        it 'can initialize' do
            expect(@cell1).to be_an_instance_of(Cell)
        end

        it 'can have a coordinate' do
            expect(@cell1.coordinate).to eq("A1")
        end

        it 'can have a different coordinate' do
            expect(@cell2.coordinate).to eq("B1")
            expect(@cell3.coordinate).to eq("A2")
        end

        it 'can have a ship in it' do
            expect(@cell1.ship).to eq(nil)
        end
    end

    describe '#empty?' do
        it 'is empty' do
            expect(@cell1.empty?).to eq(true)
        end
    end

    describe '#place_ship' do
        it 'can place a ship' do
            @cell1.place_ship(@cruiser)

            expect(@cell1.ship).to eq(@cruiser)
            expect(@cell1.empty?).to eq(false)
            expect(@cell2.ship).to eq(nil)
            expect(@cell2.empty?).to eq(true)
        end
    end

    describe '#fired_upon?' do
        it 'hasnt been fired upon' do
            expect(@cell1.fired_upon?).to eq(false)
            expect(@cell2.fired_upon?).to eq(false)
        end
    end

    describe '#fire_upon' do
        it 'cell is fired upon' do #also reduces ship Health by 1
            @cell1.fire_upon
            expect(@cell1.fired_upon?).to eq(true)
            expect(@cell2.fired_upon?).to eq(false)
        end
    end

    describe '#render' do
        it 'render a cell to be .' do
            expect(@cell1.render).to eq(".")
        end
        it 'renders a cell to be M' do
            @cell1.fire_upon
            expect(@cell1.render).to eq("M")
        end  
        it 'renders a cell to be . if a ship is there' do
            @cell2.place_ship(@cruiser)
            expect(@cell2.render).to eq(".")
        end  
        it  'renders a cell to be a ship' do
            expect(@cell2.render(true)).to eq("S")
        end
        it 'renders a cell to be hit' do
            @cell2.fire_upon
            expect(@cell2.render).to eq("H")
        end
        it 'it renders when a ship is sunk' do
            expect(@cruiser.sunk?).to eq(false)
            @cell2.fire_upon
            @cell2.fire_upon
            expect(@cruiser.sunk?).to eq(true)
            expect(@cell2.render).to eq("X")
        end
    end
end