class Skill < ActiveRecord::Base
  belongs_to :level
  has_many :attainments
  has_many :registrations, :through => :attainments

  attr_accessible :name
end
