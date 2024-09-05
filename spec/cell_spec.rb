require './spec_helper'

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
            expect(@cell2.coordinate).to eq("A2")
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
end