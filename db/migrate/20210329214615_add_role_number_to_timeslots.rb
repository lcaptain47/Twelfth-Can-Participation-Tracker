class AddRoleNumberToTimeslots < ActiveRecord::Migration[6.1]
  def change
    add_column :timeslots, :role_number, :int
  end
end
