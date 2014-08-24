class PaymentPlanInstalment < ActiveRecord::Base
  attr_accessible :due_date, :payment_amount, :payment_plan_id
end
