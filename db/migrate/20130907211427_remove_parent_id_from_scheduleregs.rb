class RemoveParentIdFromScheduleregs < ActiveRecord::Migration
  def up
  	remove_column :scheduleregs, :parent_id
  end

  def down
  	add_column :scheduleregs, :parent_id, :integer
  end
end
