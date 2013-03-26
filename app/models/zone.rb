class Zone < ActiveRecord::Base
  belongs_to :facility
  has_many :schedules

  attr_accessible :name
end
