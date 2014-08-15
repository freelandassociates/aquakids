class AddRegistrationFeeToPrograms < ActiveRecord::Migration

  def up
  	add_column :programs, :registration_fee, :integer  	
  end

  def down
  	remove_column :programs, :registration_fee
  end

end
