class Session < ActiveRecord::Base
  has_many :schedules

  attr_accessible :name
end
