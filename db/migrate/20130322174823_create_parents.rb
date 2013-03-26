class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :cell_phone
      t.string :home_phone
      t.string :work_phone
      t.string :care_provider
      t.string :care_provider_phone
      t.text :comments
      t.string :email
      t.string :alternate_email
      t.string :emergency_contact
      t.string :emergency_contact_phone
      t.string :insurance
      t.string :insurance_phone
      t.string :policy_number
      t.string :doctor
      t.string :doctor_phone

      t.timestamps
    end
  end
end
