class Facility < ActiveRecord::Base
  has_many :schedules

  validates_presence_of :name, :location_id

  attr_accessible :name, :location_id
end
