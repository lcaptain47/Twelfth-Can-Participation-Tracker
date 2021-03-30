# frozen_string_literal: true

class User < ApplicationRecord
  before_save :default_values
  belongs_to :user_role
  has_many :timeslots, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  # Creates a user from google account info
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url,
                user_role_id: UserRole.find_by(name: 'User').id).find_or_create_by!(email: email)
  end

  def default_values
    self.total_approved_hours = total_approved_hours.presence || 0.0
    self.total_unapproved_hours = total_unapproved_hours.presence || 0.0
    self.volunteer_hours = volunteer_hours.presence || 0.0
    self.pantry_runner_hours = pantry_runner_hours.presence || 0.0
    self.front_office_hours = front_office_hours.presence || 0.0
  end
end
