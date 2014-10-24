class ParentReadOnlySerializer < ActiveModel::Serializer
  attributes  :id,
              :first_name,
              :last_name,
              :address_1,
              :address_2,
              :city, 
              :state, 
              :zip, 
              :home_phone, 
              :cell_phone, 
              :work_phone, 
              :email, 
              :alternate_email,
              :comments, 
              :location_id,
              :payment_due
  
  def payment_due
    0
  end

end