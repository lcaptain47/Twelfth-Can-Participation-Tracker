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
    if self.is_approved && user != nil
      user.total_unapproved_hours -= self.duration

      case self.role
      when 'Front Desk'
        user.front_office_hours -= self.duration
      when 'Runner'
        user.pantry_runner_hours -= self.duration
      when 'Volunteer'
        user.volunteer_hours -= self.duration
      end
      user.save

    elsif user != nil    
      user.total_unapproved_hours -= self.duration
      user.save
    end

  end 

end
