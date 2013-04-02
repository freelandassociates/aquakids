class RemoveFacilityIdFromZones < ActiveRecord::Migration
  def up
  	remove_column :zones, :facility_id
  	add_column :schedules, :facility_id, :integer
  end

  def down
  	remove_column :schedules, :facility_id
  	add_column :zones, :facility_id, :integer
  end
end
