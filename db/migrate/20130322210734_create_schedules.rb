class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :start_date
      t.date :stop_date
      t.integer :day_of_week
      t.time :start_time
      t.time :stop_time
      t.integer :size
      t.text :comments

      t.timestamps
    end
  end
end
