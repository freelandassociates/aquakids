class Parent < ActiveRecord::Base
  belongs_to :user
  has_many :children

  validates_presence_of :address_1, :address_2, :alternate_email, :care_provider, :care_provider_phone, :cell_phone, :city, :comments, :doctor, :doctor_phone, :email, :emergency_contact, :emergency_contact_phone, :first_name, :home_phone, :insurance, :insurance_phone, :last_name, :policy_number, :state, :work_phone, :zip  

  attr_accessible :address_1, :address_2, :alternate_email, :care_provider, :care_provider_phone, :cell_phone, :city, :comments, :doctor, :doctor_phone, :email, :emergency_contact, :emergency_contact_phone, :first_name, :home_phone, :insurance, :insurance_phone, :last_name, :policy_number, :state, :work_phone, :zip

  def full_name
	[last_name, first_name].join(', ')
  end

end
