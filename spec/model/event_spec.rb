# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event do
  it 'is valid with valid input' do
    event = described_class.new(name: 'Test Event', date: '12-12-2021')
    expect(event).to be_valid
  end

  it 'is not valid without a name' do
    event = described_class.new(date: '12-12-2021')
    expect(event).not_to be_valid
  end

  it 'is not valid without a date' do
    event = described_class.new(name: 'Test Event')
    expect(event).not_to be_valid
  end
end
