class UpdateParentLocations < ActiveRecord::Migration
  def change
  	Parent.update_all(location_id: '1')
  end

end
