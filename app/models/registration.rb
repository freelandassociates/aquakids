class Registration < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :child
  belongs_to :location
  has_many :attainments
  has_many :skills, :through => :attainments

  attr_accessible :comments
end
