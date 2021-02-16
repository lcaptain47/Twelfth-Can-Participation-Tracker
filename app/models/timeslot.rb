# frozen_string_literal: true

class Timeslot < ApplicationRecord
  belongs_to :event
  validates :time, uniqueness: { scope: :event_id }
end
