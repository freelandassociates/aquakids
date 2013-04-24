class Copyclass
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :program, :date_offset, :time_offset

  validates_presence_of :program, :date_offset, :time_offset

  validates :date_offset, :numericality => { :only_integer => true }
  validates :time_offset, :numericality => { :only_integer => true }
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end