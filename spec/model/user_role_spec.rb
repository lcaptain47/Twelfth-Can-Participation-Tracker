# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRole do
  it 'is valid with valid input' do
    role = described_class.new(name: 'President', can_create: true, can_delete: true)
    expect(role).to be_valid
    role = described_class.new(name: 'User1', can_create: false, can_delete: false)
    expect(role).to be_valid
  end

  it 'is not valid without a name' do
    role = described_class.new(can_create: true, can_delete: true)
    expect(role).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    role = described_class.new(name: 'President', can_create: true, can_delete: true)
    role.save
    role = described_class.new(name: 'President', can_create: true, can_delete: true)
    expect(role).not_to be_valid
  end

  it 'is valid with a unique name and valid input' do
    role = described_class.new(name: 'President', can_create: true, can_delete: true)
    role.save
    role2 = described_class.new(name: 'President2', can_create: true, can_delete: true)
    expect(role2).to be_valid
  end

  it 'is not valid without a can_create entry' do
    role = described_class.new(name: 'President', can_delete: true)
    expect(role).not_to be_valid
  end

  it 'is not valid without a can_delete entry' do
    role = described_class.new(name: 'President', can_create: true)
    expect(role).not_to be_valid
  end
end
