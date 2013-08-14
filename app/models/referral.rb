class Referral < ActiveRecord::Base
  has_many :registrations

  attr_accessible :referral_description
end
