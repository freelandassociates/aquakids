class AddLocationIdToTeachers < ActiveRecord::Migration
  def change
  	add_column :teachers, :location_id, :integer
  end
end
