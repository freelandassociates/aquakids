class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.date :date_of_birth

      t.timestamps
    end
  end
end
