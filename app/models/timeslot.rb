# frozen_string_literal: true

class Timeslot < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  validates :time, uniqueness: { scope: [:event_id, :role, :role_number]}, presence: true
  validates :time, presence: true
  validates :duration, presence: true
  validates :role, presence: true
  validates :role_number, presence: true
end
