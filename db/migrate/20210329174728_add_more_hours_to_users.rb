class AddMoreHoursToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :front_office_hours, :float
    add_column :users, :pantry_runner_hours, :float
    add_column :users, :volunteer_hours, :float
  end
end
