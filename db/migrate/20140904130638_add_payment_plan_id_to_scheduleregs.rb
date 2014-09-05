class AddPaymentPlanIdToScheduleregs < ActiveRecord::Migration
  def up
  	add_column :scheduleregs, :payment_plan_id, :integer  	
  end

  def down
  	remove_column :scheduleregs, :payment_plan_id
  end
end
