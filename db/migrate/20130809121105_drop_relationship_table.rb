class DropRelationshipTable < ActiveRecord::Migration
  def up
  	drop_table :relationships
  end

  def down
  end
end
