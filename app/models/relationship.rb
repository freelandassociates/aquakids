class Relationship < ActiveRecord::Base
  belongs_to :parent
  belongs_to :child

  attr_accessible :relationship
end
