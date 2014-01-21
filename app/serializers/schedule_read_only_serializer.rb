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
              :number,
              :number_confirmed,
              :level_id,
              :absences, 
              :specials, 
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

  def absences
    0
  end

  def specials
    0
  end

  def lessons
    case [self.sunday, self.monday, self.tuesday, self.wednesday, self.thursday, self.friday, self.saturday].count(true) 
    when 0
      return "None"
    when 1
      Date::DAYNAMES[self.day_of_week-1].to_s[0..2]
    else
      description = ""
      description += "S" if object.sunday?
      description += "M" if object.monday?
      description += "T" if object.tuesday?
      description += "W" if object.wednesday?
      description += "Th" if object.thursday?
      description += "F" if object.friday?
      description += "S" if object.saturday?
      return description
    end
  end

end