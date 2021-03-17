class AddHoursToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_approved_hours, :float
    add_column :users, :total_unapproved_hours, :float
  end
end
