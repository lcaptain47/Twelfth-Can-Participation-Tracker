class UserRole < ApplicationRecord
    has_many :users
    validates :name, presence: true, uniqueness: {case_sensitive: false}
    validates :can_create, inclusion: {in: [true,false]}
    validates :can_delete, inclusion: {in: [true,false]}
end
