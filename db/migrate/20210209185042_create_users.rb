class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :total_approved_hours
      t.integer :total_unapproved_hours
      t.boolean :is_officer
      t.boolean :is_president
      t.timestamps
    end
  end
end
