class Location < ActiveRecord::Base
  has_many :schedules
  has_many :users
  
  validates_presence_of :name

  attr_accessible :name

  cattr_accessor :current_id
end
