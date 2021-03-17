class User < ApplicationRecord
  belongs_to :user_role
  has_many :timeslots
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # return nil unless email =~ /@mybusiness.com\z/
    # byebug
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url, user_role_id: UserRole.find_by(name: "User").id, total_approved_hours: 0.0, total_unapproved_hours: 0.0).find_or_create_by!(email: email)
  end
end
