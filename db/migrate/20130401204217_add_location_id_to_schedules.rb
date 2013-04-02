class AddLocationIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :location_id, :integer
  end
end
