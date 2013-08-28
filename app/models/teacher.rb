class Teacher < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :location
  has_many :schedules

  validates_presence_of :address_1, :address_2, :cell_phone, :city, :email, :first_name, :home_phone, :last_name, :state, :work_phone, :zip, :location_id

  attr_accessible :address_1, :address_2, :cell_phone, :city, :email, :first_name, :home_phone, :last_name, :middle_name, :notes, :state, :work_phone, :zip, :location_id

  def self.default_scope
    # Case statement on location_id... needs refactoring but will work for now
     case User.current.location_id 
      when 1
        where(:location_id => 1)
      when 2
        where(:location_id => 2)
      when 3
        where(:location_id => 3)
      when 4
        where(:location_id => 4)
      when 5
        where(:location_id => 5)
      when 6
        where(:location_id => 6)
      else
        nil
      end
  end

  def full_name
	 [first_name, middle_name, last_name].join(' ')
  end

end
