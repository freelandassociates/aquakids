class AddLocationIdAndFacilityIdToZones < ActiveRecord::Migration
  def change
  	add_column :zones, :location_id, :integer
  	add_column :zones, :facility_id, :integer
  end
end
