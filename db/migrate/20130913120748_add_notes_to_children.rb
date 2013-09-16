class AddNotesToChildren < ActiveRecord::Migration
  def change
    add_column :children, :notes, :text
  end
end
