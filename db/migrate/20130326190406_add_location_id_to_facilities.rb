class AddLocationIdToFacilities < ActiveRecord::Migration
  def change
  	add_column :facilities, :location_id, :integer
  end
end
