class AddRoleAmountsAndDescToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :description, :text
    add_column :events, :volunteers, :int
    add_column :events, :front_desks, :int
    add_column :events, :runners, :int
  end
end
