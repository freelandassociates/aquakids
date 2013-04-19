class RemoveLocationIdFromFacilities < ActiveRecord::Migration
  def up
  	remove_column :facilities, :location_id
  end

  def down
  	add_column :facilities, :location_id, :integer
  end
end
