class AddDaysToSchedules < ActiveRecord::Migration
  def self.up
  	add_column :schedules, :sunday, :boolean
  	add_column :schedules, :monday, :boolean
  	add_column :schedules, :tuesday, :boolean
  	add_column :schedules, :wednesday, :boolean
  	add_column :schedules, :thursday, :boolean
  	add_column :schedules, :friday, :boolean
  	add_column :schedules, :saturday, :boolean
  end

  def self.down
  	remove_column :schedules, :sunday
  	remove_column :schedules, :monday
  	remove_column :schedules, :tuesday
  	remove_column :schedules, :wednesday
  	remove_column :schedules, :thursday
  	remove_column :schedules, :friday
  	remove_column :schedules, :saturday
  end

end
