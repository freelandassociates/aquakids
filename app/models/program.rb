class Program < ActiveRecord::Base
  has_paper_trail
  
  has_many :schedules
  has_many :payment_plans

  validates_presence_of :name

  attr_accessible :name, :registration_fee, :registration_fee_dollars

  def registration_fee_dollars
  	self.registration_fee.to_f / 100
  end

  def registration_fee_dollars=(val)
  	self.registration_fee = val.to_f * 100
  end

end
