class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :cell_phone
      t.string :home_phone
      t.string :work_phone
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
