class Schedule < ActiveRecord::Base
  belongs_to :level
  belongs_to :activity
  belongs_to :type
  belongs_to :program
  belongs_to :teacher
  belongs_to  :location
  belongs_to :facility
  belongs_to :zone
  has_many :registrations
  has_many :children, :through => :registrations

  validates_presence_of :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id

  attr_accessible :comments, :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id

  def self.default_scope
    # Case statement on location_id... needs refactoring but will work for now
    case User.current.location_id 
    when 1
      where(:location_id => 1)
    when 2
      where(:location_id => 2)
    when 3
      where(:location_id => 3)
    when 4
      where(:location_id => 4)
    when 5
      where(:location_id => 5)
    when 6
      where(:location_id => 6)
    else
      nil
    end

  end

end