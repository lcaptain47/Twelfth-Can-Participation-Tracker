class User < ApplicationRecord
    before_save { self.email = email.downcase }

    validates :first_name, presence: true, length: {minimum: 2, maximum: 30}
    validates :last_name, presence: true, length: {minimum: 2, maximum: 30}
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true,
        uniqueness: {case_sensitive: false},
        length: {maximum: 100},
        format: {with: EMAIL_REGEX}
    has_secure_password

end
