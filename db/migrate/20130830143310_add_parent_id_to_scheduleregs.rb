class AddParentIdToScheduleregs < ActiveRecord::Migration
  def up
  	add_column :scheduleregs, :parent_id, :integer
  end

  def down
  	remove_column :scheduleregs, :parent_id
  end
end
