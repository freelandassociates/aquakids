class Location < ActiveRecord::Base
  has_many :facilities

  validates_presence_of :name

  attr_accessible :name
end
