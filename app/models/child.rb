class Child < ActiveRecord::Base
  belongs_to :parent
  has_many :registrations
  has_many :schedules, :through => :registrations

  attr_accessible :date_of_birth, :first_name, :last_name, :sex, :parent_id

  validates_presence_of :date_of_birth, :first_name, :last_name, :sex, :parent_id

  def parent_last_name
  	self.parent.last_name
  end

  def parent_first_name
  	self.parent.first_name
  end

  def parent_address_1
    self.parent.address_1
  end

  def parent_address_2
    self.parent.address_2
  end

  def parent_city
    self.parent.city
  end

  def parent_state
    self.parent.state
  end

  def parent_zip
    self.parent.zip
  end

  def parent_cell_phone
    self.parent.cell_phone
  end

  def parent_home_phone
    self.parent.home_phone
  end

  def parent_work_phone
    self.parent.work_phone
  end

  def parent_email
    self.parent.email
  end

  def emergency_phone
    self.parent.emergency_contact_phone
  end

  def emergency_contact
    self.parent.emergency_contact
  end
 

end
