require './spec/spec_helper'

RSpec.describe Computer do
    before(:each) do
        @computer = Computer.new
    end

        it 'exists' do
            expect(@computer).to be_an_instance_of(Computer)
        end
end