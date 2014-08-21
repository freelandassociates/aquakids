class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.string :name
      t.integer :program_id
      t.integer :payment_plan_fee
      t.integer :per_lesson_cost

      t.timestamps
    end
  end
end
