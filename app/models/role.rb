class Role < ActiveRecord::Base

  has_many :users
  
  attr_accessible :role
  
end
