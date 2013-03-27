class Program < ActiveRecord::Base
  has_many :schedules

  validates_presence_of :name

  attr_accessible :name
end
