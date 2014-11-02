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
              :total_registration_fee_due,
              :total_lesson_cost_due,
              :total_cost_due,
              :total_payments_made,
              :net_payment_due,
              :number_of_children

end