class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.text :comments

      t.timestamps
    end
  end
end
