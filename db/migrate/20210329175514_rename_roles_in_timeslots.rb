class RenameRolesInTimeslots < ActiveRecord::Migration[6.1]
  def change
    remove_column :timeslots, :job_type
    add_column :timeslots, :role, :string
  end
end
