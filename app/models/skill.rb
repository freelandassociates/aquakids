class Skill < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :level
  has_many :attainments
  has_many :registrations
  # has_many :registrations, :through => :attainments

  validates_presence_of :name, :level_id

  attr_accessible :name, :level_id
end
