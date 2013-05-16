class ScheduleReadOnlySerializer < ActiveModel::Serializer
  attributes  :id, 
              :program_id, 
              :start_date,
              :stop_date, 
              :day_of_week,
              :lessons,
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
  
  def number
	  # This is the number of children signed up for this class
    0
  end

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