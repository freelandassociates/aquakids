class RemoveChildIdFromSchedules < ActiveRecord::Migration
  def up
  	remove_column :schedules, :child_id
  end

  def down
  	add_column :schedules, :child_id, :integer
  end
end
