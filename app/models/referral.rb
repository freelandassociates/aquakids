class Referral < ActiveRecord::Base
  has_many :scheduleregs

  attr_accessible :referral_description
end
