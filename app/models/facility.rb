class Facility < ActiveRecord::Base
  belongs_to :location
  has_many :zones

  attr_accessible :name
end
