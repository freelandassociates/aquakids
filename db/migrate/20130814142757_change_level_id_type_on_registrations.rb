class ChangeLevelIdTypeOnRegistrations < ActiveRecord::Migration
  def change
  	remove_column :registrations, :level_id
  	add_column :registrations, :level_id, :integer
  end

end
