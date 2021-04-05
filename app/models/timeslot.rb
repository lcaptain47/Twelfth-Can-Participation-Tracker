# frozen_string_literal: true

class Timeslot < ApplicationRecord
  before_destroy :clean_up
  belongs_to :event
  belongs_to :user, optional: true
  validates :time, uniqueness: { scope: %i[event_id role role_number] }, presence: true
  validates :time, presence: true
  validates :duration, presence: true
  validates :role, presence: true
  validates :role_number, presence: true

  def clean_up
    user = self.user
    if is_approved && !user.nil?
      user.total_unapproved_hours -= duration

      case role
      when 'Front Desk'
        user.front_office_hours -= duration
      when 'Runner'
        user.pantry_runner_hours -= duration
      when 'Volunteer'
        user.volunteer_hours -= duration
      end
      user.save

    elsif !user.nil?
      user.total_unapproved_hours -= duration
      user.save
    end
  end
end
