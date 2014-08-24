class CreatePaymentPlanInstalments < ActiveRecord::Migration
  def change
    create_table :payment_plan_instalments do |t|
      t.integer :payment_plan_id
      t.date :due_date
      t.integer :payment_amount

      t.timestamps
    end
  end
end
