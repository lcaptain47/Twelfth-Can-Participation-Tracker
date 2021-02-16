# frozen_string_literal: true

class CreateTimeslots < ActiveRecord::Migration[6.1]
  def change
    create_table :timeslots do |t|
      t.time :time
      t.integer :duration
      t.boolean :is_approved
      t.string :job_type

      t.timestamps
    end
  end
end
