# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :timeslots
  validates :date, presence: true
  validates :name, presence: true
end
