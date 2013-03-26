class Schedule < ActiveRecord::Base
  belongs_to :level
  belongs_to :activity
  belongs_to :type
  belongs_to :session
  belongs_to :teacher
  belongs_to :zone
  has_many :registrations
  has_many :children, :through => :registrations

  attr_accessible :comments, :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time
end
