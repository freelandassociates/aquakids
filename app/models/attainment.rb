class Attainment < ActiveRecord::Base
  belongs_to :skill
  belongs_to :registration

  attr_accessible :comments, :date_achieved
end
