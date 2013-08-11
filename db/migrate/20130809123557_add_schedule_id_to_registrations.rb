class AddScheduleIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :schedule_id, :integer
    add_column :registrations, :child_id, :integer
  end
end
