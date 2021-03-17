# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeslot do
  before do
    event = Event.new(name: 'Test Event', date: '12-12-2021')
    event.save
  end

  it 'is valid with valid input' do
    timeslot = described_class.new(time: '12:00', duration: 60, event: Event.first)
    expect(timeslot).to be_valid
    timeslot.save
    timeslot = described_class.new(time: '1:00', duration: 60, event_id: Event.first.id)
    expect(timeslot).to be_valid
  end

  it 'is not valid with a duplicate time' do
    timeslot = described_class.new(time: '12:00', duration: 60, event_id: Event.first.id)
    timeslot.save
    timeslot = described_class.new(time: '12:00', duration: 60, event_id: Event.first.id)
    expect(timeslot).not_to be_valid
  end

  it 'is not valid without a duration' do
    timeslot = described_class.new(time: '12:00', event_id: Event.first.id)
    expect(timeslot).not_to be_valid
  end

  it 'is not valid without a time' do
    timeslot = described_class.new(duration: 60, event_id: Event.first.id)
    expect(timeslot).not_to be_valid
  end

  it 'is not valid without an event' do
    timeslot = described_class.new(time: '12:00', duration: 60)
    expect(timeslot).not_to be_valid
  end
end
