class Role < ActiveRecord::Base
	has_many :users

 	attr_accessible :Role, :role
end
