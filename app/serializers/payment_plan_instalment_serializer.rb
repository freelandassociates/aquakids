class PaymentPlanInstalmentSerializer < ActiveModel::Serializer
  attributes :id, :payment_plan_id, :due_date, :payment_amount
end
