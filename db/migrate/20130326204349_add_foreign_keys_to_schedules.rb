class AddForeignKeysToSchedules < ActiveRecord::Migration
  def up
  	add_column :schedules, :level_id, :integer
  	add_column :schedules, :type_id, :integer
  	add_column :schedules, :zone_id, :integer
  	add_column :schedules, :activity_id, :integer
  	add_column :schedules, :program_id, :integer
  	add_column :schedules, :teacher_id, :integer
  	add_column :schedules, :child_id, :integer
  end

  def down
  	remove_column :schedules, :level_id
  	remove_column :schedules, :type_id
  	remove_column :schedules, :zone_id
  	remove_column :schedules, :activity_id
  	remove_column :schedules, :program_id
  	remove_column :schedules, :teacher_id
  	remove_column :schedules, :child_id
  end  
end
