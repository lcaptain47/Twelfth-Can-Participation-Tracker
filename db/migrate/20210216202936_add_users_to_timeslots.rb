class AddUsersToTimeslots < ActiveRecord::Migration[6.1]
  def change
    add_column :timeslots, :user_id, :int
  end
end
