class Level < ActiveRecord::Base
  has_paper_trail
  
  has_many :schedules
  has_many :skills

  validates_presence_of :name

  attr_accessible :name
end
