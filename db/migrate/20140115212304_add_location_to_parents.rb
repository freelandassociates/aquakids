class AddLocationToParents < ActiveRecord::Migration

  def change
  	add_column :parents, :location_id, :integer
  	Parent.reset_column_information
  	Parent.update_all(location_id: '1')
  end

end
