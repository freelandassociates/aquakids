class PaymentPlan < ActiveRecord::Base
  has_paper_trail

  belongs_to :program
  has_many :payment_plan_instalments
  has_many :scheduleregs

  validates_presence_of :name, :program_id

  attr_accessible :program_id, :name, :payment_plan_fee, :payment_plan_fee_dollars, :per_lesson_cost, :per_lesson_cost_dollars

  def payment_plan_fee_dollars
    self.payment_plan_fee.to_f / 100
  end

  def payment_plan_fee_dollars=(val)
    self.payment_plan_fee = val.to_f * 100
  end

  def per_lesson_cost_dollars
    self.per_lesson_cost.to_f / 100
  end

  def per_lesson_cost_dollars=(val)
    self.per_lesson_cost = val.to_f * 100
  end

end