require 'rails_helper'

RSpec.describe Timeslot do

    before(:each) do
        event = Event.new(name: 'Test Event', date: '12-12-2021')
        event.save
    end

    it 'is valid with valid input' do
        timeslot = Timeslot.new(time: '12:00', duration: 60, event: Event.first)
        expect(timeslot).to be_valid
        timeslot.save
        timeslot = Timeslot.new(time: '1:00', duration: 60, event_id: Event.first.id)
        expect(timeslot).to be_valid
    end

    it 'is not valid with a duplicate time' do
        timeslot = Timeslot.new(time: '12:00', duration: 60, event_id: Event.first.id)
        timeslot.save
        timeslot = Timeslot.new(time: '12:00', duration: 60, event_id: Event.first.id)
        expect(timeslot).to_not be_valid
    end

    it 'is not valid without a duration' do
        timeslot = Timeslot.new(time: '12:00', event_id: Event.first.id)
        expect(timeslot).to_not be_valid
    end

    it 'is not valid without a time' do
        timeslot = Timeslot.new(duration: 60, event_id: Event.first.id)
        expect(timeslot).to_not be_valid
    end

    it 'is not valid without an event' do
        timeslot = Timeslot.new(time: '12:00', duration: 60)
        expect(timeslot).to_not be_valid
    end
end