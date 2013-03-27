class AddLevelIdToSkills < ActiveRecord::Migration
  def change
  	add_column :skills, :level_id, :integer
  end
end
