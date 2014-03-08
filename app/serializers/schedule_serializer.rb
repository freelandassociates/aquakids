class ScheduleSerializer < ActiveModel::Serializer
  attributes  :id, 
              :program_id, 
              :start_date,
              :stop_date, 
              :day_of_week,
              # :lessons,
              :start_time,
              :stop_time,
              :size,
              :sunday,
              :monday,
              :tuesday,
              :wednesday,
              :thursday,
              :friday,
              :saturday,
              # :number,
              :level_id,
              # :absences, 
              # :specials, 
              :type_id,
              :teacher_id,
              :zone_id,
              :comments,
              :activity_id,
              :location_id,
              :facility_id
  
  # def number
	 #  # This is the number of children signed up for this class
  #   0
  # end

  # def stop_time
  #   # object.stop_time.utc + (Time.now.utc_offset)
  #   # object.stop_time.to_s[0..9] + "T" + object.stop_time.to_s[11..18]
  #   object.stop_time.to_s[11..18]
  # end

  # def start_time
  #   # object.start_time.utc + (Time.now.utc_offset)
  #   # object.start_time.to_s[0..9] + "T" + object.start_time.to_s[11..18]
  #   object.start_time.to_s[11..18]
  # end


  def absences
    0
  end

  def specials
    0
  end

  def lessons
    Date::DAYNAMES[self.day_of_week]
  end

end