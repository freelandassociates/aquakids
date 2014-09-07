class ScheduleregSerializer < ActiveModel::Serializer
  attribute  :id, :key => :registration_id
  attribute  :created_at, :key => :registration_date
  attributes :special,
             :child_last_name,
             :child_first_name,
             :child_dob,
             :child_age,
             :child_sex,
             :parent_last_name,
             :parent_first_name,
             :parent_address_1,
             :parent_address_2,
             :parent_city,
             :parent_state,
             :parent_zip,
             :parent_cell_phone,
             :parent_home_phone,
             :parent_work_phone,
             :parent_email,
             :emergency_phone,
             :emergency_contact,
             :referral,
             :referred_by,
             :comments,
             :status,
             :class_cost,
             :entry_date,
             :exit_date,
             :skill,
             :continuance,
             :promoted_to,
             :payment_due_date,
             :payment_plan_name,
             :user
  
  def special
    if object.wait == 'Y'
      "Waitlist"
    end
  end            

  def child_last_name
    object.child.last_name
  end

  def child_first_name
    object.child.first_name
  end

  def child_dob
    object.child.date_of_birth
  end

  def child_age
    now = Time.now.utc.to_date
    @age_in_years = now.year - object.child.date_of_birth.year - ((now.month > object.child.date_of_birth.month || (now.month == object.child.date_of_birth.month && now.day >= object.child.date_of_birth.day)) ? 0 : 1)
    if @age_in_years < 1
      # "less than one" 
      # ((now.year - object.child.date_of_birth.year) * 12) + (now.month - object.child.date_of_birth.month)
      @age_in_months = now.month - object.child.date_of_birth.month
      if now.day < object.child.date_of_birth.day
        @age_in_months = @age_in_months - 1
      end
      # Cater for 0 or negative value as overlapping year end and add 12 to correct value
      if @age_in_months < 1
        @age_in_months = @age_in_months + 12
      end
      return @age_in_months.to_s + " mo"
    else
      # (now - object.child.date_of_birth).to_i/36.525.round
      @age_in_years = ((now - object.child.date_of_birth).to_i/36.525).round/10.0
      if @age_in_years.to_s.include?(".0")
        @age_in_years.to_s[0..-3] + " yrs"
      else
        @age_in_years.to_s + " yrs"
      end
    end
  end

  def child_sex
    object.child.sex
  end

  def parent_last_name
    object.child.parent_last_name
  end

  def parent_first_name
    object.child.parent_first_name
  end

  def parent_address_1
    object.child.parent_address_1
  end

  def parent_address_2
    object.child.parent_address_2
  end

  def parent_city
    object.child.parent_city
  end

  def parent_state
    object.child.parent_state
  end

  def parent_zip
    object.child.parent_zip
  end

  def parent_cell_phone
    object.child.parent_cell_phone
  end

  def parent_home_phone
    object.child.parent_home_phone
  end

  def parent_work_phone
    object.child.parent_work_phone
  end

  def parent_email
    object.child.parent_email
  end

  def emergency_phone
    object.child.emergency_phone
  end

  def emergency_contact
    object.child.emergency_contact
  end

  def referral
    if object.referral.nil?
      ""
    else
      object.referral.referral_description
    end
  end

  def class_cost
    0
  end

  def status
    ''
  end

  def skill
    if object.skill.nil?
      ""
    else
      object.skill.name
    end
  end

  def promoted_to
    if object.level.nil?
      ""
    else
      object.level.name
    end
  end

  def user
    User.find(object.versions.last.whodunnit).username if object.versions.count > 0
  end

  def payment_plan_name
    if object.payment_plan_id.nil?
      ""
    else
      PaymentPlan.find(object.payment_plan_id).name
    end
  end

end