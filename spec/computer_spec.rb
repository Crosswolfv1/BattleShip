require './spec/spec_helper'

RSpec.describe Computer do
    before(:each) do
        @computer = Computer.new
    end

        it 'exists' do
            expect(@computer).to be_an_instance_of(Computer)
        end

        it '#generate_coordinates' do
            expect(@computer.generate_coordinates(3).count).to eq(3)
            expect(@computer.generate_coordinates(2).count).to eq(2)
        end
end