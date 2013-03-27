class Schedule < ActiveRecord::Base
  belongs_to :level
  belongs_to :activity
  belongs_to :type
  belongs_to :program
  belongs_to :teacher
  belongs_to :zone
  has_many :registrations
  has_many :children, :through => :registrations

  validates_presence_of :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :zone_id

  attr_accessible :comments, :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :zone_id
end
