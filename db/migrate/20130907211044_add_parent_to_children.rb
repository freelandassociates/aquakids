class AddParentToChildren < ActiveRecord::Migration
  def up
  	add_column :children, :parent_id, :integer  	
  end

  def down
  	remove_column :children, :parent_id
  end
end
