class CreateDays < ActiveRecord::Migration
  def up
    create_table :days do |t|
      t.string :name

      t.timestamps
    end

    Day.create!(:name => "Sunday")
    Day.create!(:name => "Monday")
    Day.create!(:name => "Tuesday")
    Day.create!(:name => "Wednesday")
    Day.create!(:name => "Thursday")
    Day.create!(:name => "Friday")
    Day.create!(:name => "Saturday")
  end

  def down
	drop_table :days
  end

end