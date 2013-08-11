class RegistrationSerializer < ActiveModel::Serializer
  attributes  :id, 
              :special,
              :child_last_name,
              :child_first_name,
              :child_dob,
              :child_age,
              :child_sex,
              :parent_last_name,
              :parent_first_name,
              :referral,
              :referred_by,
              :parent_address_1,
              :parent_address_2,
              :parent_city,
              :parent_state,
              :parent_zip,
              :parent_cell_phone,
              :parent_home_phone,
              :parent_work_phone,
              :status,
              :class_cost,
              :entry_date,
              :exit_date,
              :skill,
              :continuance,
              :promoted_to,
              :comments,
              :payment_due_date,
              :registration_date,
              :user,
              :registration_number,
              :emergency_phone,
              :emergency_contact,
              :parent_email,
              :comments

def child_last_name
  object.child.last_name
end

end