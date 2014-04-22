class CreateCapacities < ActiveRecord::Migration
  def up
    create_table :capacities do |t|
      t.string :code
      t.string :name
     
      t.timestamps
    end

  end

  def down
  	drop_table :capacities
  end

end
