class RemoveParentIdFromChildren < ActiveRecord::Migration
  def up
  	remove_column :children, :parent_id
  end

  def down
  	add_column :children, :parent_id, :integer
  end
end
