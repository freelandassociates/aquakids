class AddLocationIdToRegistrations < ActiveRecord::Migration
  def change
  	add_column :registrations, :location_id, :integer
  end
end
