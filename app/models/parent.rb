class Parent < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :children
  # has_many :scheduleregs
  # has_many :schedules, :through => :scheduleregs

  validates_presence_of :address_1, :address_2, :cell_phone, :city, :first_name, :home_phone, :last_name, :state, :zip, :location_id

  attr_accessible :address_1, :address_2, :alternate_email, :care_provider, :care_provider_phone, :cell_phone, :city, :comments, :doctor, :doctor_phone, :email, :emergency_contact, :emergency_contact_phone, :first_name, :home_phone, :insurance, :insurance_phone, :last_name, :policy_number, :state, :work_phone, :zip, :location_id

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
	[last_name, first_name].join(', ')
  end

  def total_registration_fee_due
    # Initialize variable for total payment due amount
    i = 0
    # Loop through each child of this parent
    self.children.each do |child|
      i += child.total_registration_fee_due
    end
    # Return total payment due
    return i
  end

  def total_lesson_cost_due
    0
  end

  def total_cost_due
    3.2
  end

  def total_payments_made
    1.8
  end

  def net_payment_due
    total_cost_due - total_payments_made
  end

  def number_of_children
    self.children.count
  end

end
