class DropSessions < ActiveRecord::Migration
  def up
  	drop_table :sessions
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
