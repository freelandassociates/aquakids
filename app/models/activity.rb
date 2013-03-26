class Activity < ActiveRecord::Base
  has_many :schedules

  attr_accessible :name
end
