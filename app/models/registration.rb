class Registration < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :schedule
  belongs_to :child
  belongs_to :location
  belongs_to :referral
  belongs_to :skill
  belongs_to :level
  has_many :attainments
  # has_many :skills, :through => :attainments

  attr_accessible :comments
  
end
