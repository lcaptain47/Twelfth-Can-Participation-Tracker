class CreateUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_roles do |t|
      t.string :name
      t.boolean :can_create
      t.boolean :can_delete

      t.timestamps
    end
  end
end
