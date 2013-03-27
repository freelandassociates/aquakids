class Child < ActiveRecord::Base
  has_many :relationships
  has_many :parents, :through => :relationships
  has_many :registrations
  has_many :schedules, :through => :registrations

  attr_accessible :date_of_birth, :first_name, :last_name, :sex

  validates_presence_of :date_of_birth, :first_name, :last_name, :sex
  
end
