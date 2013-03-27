class RemoveLocationIdFromZones < ActiveRecord::Migration
  def up
  	remove_column :zones, :location_id
  end

  def down
  	add_column :zones, :location_id, :integer
  end
end
