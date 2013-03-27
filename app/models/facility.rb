class Facility < ActiveRecord::Base
  belongs_to :location
  has_many :zones

  validates_presence_of :name, :location_id

  attr_accessible :name, :location_id
end
