class AddSpacesToSchedule < ActiveRecord::Migration
  def up
  	add_column :schedules, :spaces, :integer  	
  end

  def down
  	remove_column :schedules, :spaces
  end
end
