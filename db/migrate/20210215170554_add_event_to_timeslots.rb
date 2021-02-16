# frozen_string_literal: true

class AddEventToTimeslots < ActiveRecord::Migration[6.1]
  def change
    add_column :timeslots, :event_id, :int
  end
end
