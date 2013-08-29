class Attainment < ActiveRecord::Base
  belongs_to :skill
  belongs_to :schedulereg

  attr_accessible :comments, :date_achieved
end
