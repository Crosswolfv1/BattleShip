require 'spec_helper'

RSpec.describe Ship do
    before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    end

    it 'it exists' do
        cruiser = Ship.new("Cruiser", 3)

        expect(cruiser).to be_an_instance_of(Ship)
        expect(cruiser.name).to eq("Cruiser")
        expect(cruiser.length).to eq(3)
    end

    it'has health' do
        
        expect(@cruiser.health).to eq(3)
    end

    it 'can sink' do
        expect(@cruiser.sunk?).to equal(false)
    end

    it 'can take a hit' do
        expect(@cruiser.health).to eq(3)
        @cruiser.hit
        expect(@cruiser.health).to eq(2)
    end

    it 'shows true if sunk' do
        expect(@cruiser.sunk?).to eq(false)
        @cruiser.hit
        @cruiser.hit
        @cruiser.hit
        expect(@cruiser.sunk?).to eq(true)
    end

end