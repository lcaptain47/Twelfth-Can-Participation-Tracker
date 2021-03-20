# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :timeslots, dependent: :destroy
  validates :date, presence: true
  validates :name, presence: true
end
