class AddLocationIdToTeachers < ActiveRecord::Migration
  def change
  	add_column :parents, :location_id, :integer
  end
end
