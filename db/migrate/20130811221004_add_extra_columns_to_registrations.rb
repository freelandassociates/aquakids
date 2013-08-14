class AddExtraColumnsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :special, :string
    add_column :registrations, :referral_id, :integer
    add_column :registrations, :referred_by, :string
    add_column :registrations, :entry_date, :date
    add_column :registrations, :exit_date, :date
    add_column :registrations, :skill_id, :integer
    add_column :registrations, :continuance, :string
    add_column :registrations, :payment_due_date, :date
    add_column :registrations, :level_id, :date

  end
end
