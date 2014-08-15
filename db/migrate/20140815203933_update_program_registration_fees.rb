class UpdateProgramRegistrationFees < ActiveRecord::Migration

  def change
  	Program.update_all(registration_fee: "0")
  end

end
