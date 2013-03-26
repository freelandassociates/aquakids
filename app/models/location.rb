class Location < ActiveRecord::Base
  has_many :facilities

  attr_accessible :name
end
