class Child < ActiveRecord::Base
  has_one :parent
  has_many :registrations
  has_many :schedules, :through => :registrations

  attr_accessible :date_of_birth, :first_name, :last_name, :sex, :parent_id

  validates_presence_of :date_of_birth, :first_name, :last_name, :sex, :parent_id
  
end
