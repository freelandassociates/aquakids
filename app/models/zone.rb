class Zone < ActiveRecord::Base
  has_paper_trail

  has_many :schedules

  validates_presence_of :name

  attr_accessible :name

end
