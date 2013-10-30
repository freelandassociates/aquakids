class AddWaitToSchueduleRegs < ActiveRecord::Migration
  def change
    add_column :scheduleregs, :wait, :string
  end
end
