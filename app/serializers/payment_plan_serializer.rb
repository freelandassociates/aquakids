class PaymentPlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :payment_plan_fee, :per_lesson_cost
end
