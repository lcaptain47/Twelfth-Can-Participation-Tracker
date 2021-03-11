# frozen_string_literal: true

class Timeslot < ApplicationRecord
  belongs_to :event
  # belongs_to :user, optional: true
  validates :time, uniqueness: { scope: :event_id }
end
