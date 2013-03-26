class CreateAttainments < ActiveRecord::Migration
  def change
    create_table :attainments do |t|
      t.date :date_achieved
      t.text :comments

      t.timestamps
    end
  end
end
