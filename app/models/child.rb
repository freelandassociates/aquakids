class Child < ActiveRecord::Base
  belongs_to :parent
  has_many :scheduleregs
  has_many :schedules, :through => :scheduleregs

  # attr_accessible :date_of_birth, :first_name, :last_name, :sex, :parent_id
  attr_accessible :date_of_birth, :first_name, :last_name, :sex, :parent_id, :notes

  # validates_presence_of :date_of_birth, :first_name, :last_name, :sex, :parent_id
  validates_presence_of :date_of_birth, :first_name, :last_name, :sex, :parent_id

  def full_name
    [last_name, first_name].join(', ')
  end

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

  def total_registration_fee_due
    i = 0
    # Loop through all registrations for this child
    self.scheduleregs.each do |registration|
      # Total up all registration fees
      if registration.wait.blank? # if not on waitlist
        i += registration.schedule.program.registration_fee
      end
    end
    return i
  end

  def total_payment_plan_fee_due
    i = 0
    # Loop through all registrations for this child
    self.scheduleregs.each do |registration|
      # Total up all payment plan fees (if present)
      if registration.wait.blank? # if not on waitlist
        if !registration.payment_plan_id.blank?
          plan = PaymentPlan.find(registration.payment_plan_id)
            i += plan.payment_plan_fee
        end
      end
    end
    return i
  end

  def number_of_registrations
    i = 0
    # Loop through all registrations for this child
    self.scheduleregs.each do |registration|
      # Total up all registration fees
      if registration.wait.blank? # if not on waitlist
        i += 1
      end
    end
    return i    
  end

end
