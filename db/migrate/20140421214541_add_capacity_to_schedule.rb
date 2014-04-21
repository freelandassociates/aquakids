class AddCapacityToSchedule < ActiveRecord::Migration
  def up
  	add_column :schedules, :capacity, :string	
  end

  def down
  	remove_column :schedules, :capacity
  end
end
