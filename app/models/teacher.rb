class Teacher < ActiveRecord::Base
  has_many :schedules

  validates_presence_of :address_1, :address_2, :cell_phone, :city, :email, :first_name, :home_phone, :last_name, :state, :work_phone, :zip

  attr_accessible :address_1, :address_2, :cell_phone, :city, :email, :first_name, :home_phone, :last_name, :middle_name, :notes, :state, :work_phone, :zip

  def full_name
	[first_name, last_name].join(' ')
  end

end
