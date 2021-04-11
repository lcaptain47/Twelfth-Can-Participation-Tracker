# frozen_string_literal: true

class Event < ApplicationRecord
  before_save :default_values
  has_many :timeslots, dependent: :destroy
  validates :date, presence: true
  validates :name, presence: true
  validates :description, length: {maximum: 250}

  def default_values
    self.volunteers = volunteers.presence || 0
    self.front_desks = front_desks.presence || 0
    self.runners = runners.presence || 0
  end
end
