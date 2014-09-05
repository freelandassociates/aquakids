class PaymentPlanInstalment < ActiveRecord::Base
  has_paper_trail

  belongs_to :payment_plan

  validates_presence_of :due_date, :payment_plan_id

  validates_date :due_date

  attr_accessible :due_date, :payment_amount, :payment_amount_dollars, :payment_plan_id

  def payment_amount_dollars
    self.payment_amount.to_f / 100
  end

  def payment_amount_dollars=(val)
    self.payment_amount = val.to_f * 100
  end

end
