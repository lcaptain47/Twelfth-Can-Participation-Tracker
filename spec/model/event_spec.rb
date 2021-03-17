require 'rails_helper'

RSpec.describe Event do
    it 'is valid with valid input' do
        event = Event.new(name: 'Test Event', date: '12-12-2021')
        expect(event).to be_valid
    end

    it 'is not valid without a name' do
       event = Event.new(date: '12-12-2021')
       expect(event).to_not be_valid
    end

    it 'is not valid without a date' do
        event = Event.new(name: 'Test Event')
        expect(event).to_not be_valid
    end
end