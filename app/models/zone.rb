class Zone < ActiveRecord::Base
  belongs_to :facility
  has_many :schedules

  validates_presence_of :name, :facility_id

  attr_accessible :name, :facility_id
end
