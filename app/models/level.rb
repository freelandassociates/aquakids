class Level < ActiveRecord::Base
  has_many :schedules
  has_many :skills

  attr_accessible :name
end
