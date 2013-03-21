class CreateTestEntities < ActiveRecord::Migration
  def change
    create_table :test_entities do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
