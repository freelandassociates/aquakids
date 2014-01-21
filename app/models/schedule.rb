class Schedule < ActiveRecord::Base
  belongs_to :level
  belongs_to :activity
  belongs_to :type
  belongs_to :program
  belongs_to :teacher
  belongs_to  :location
  belongs_to :facility
  belongs_to :zone
  has_many :scheduleregs
  has_many :children, :through => :scheduleregs

  validates_presence_of :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id

  validates_date :start_date, :on_or_before => :stop_date,
                              :on_or_before_message => "Start date can not be after stop date"

  validates_date :stop_date

  validates_time :start_time, :before => :stop_time,
                                 :before_message => "Start time must be before stop time"

  validates_time :stop_time

  validates :size, :numericality => { :only_integer => true }

  validate :check_days

  attr_accessible :comments, :day_of_week, :size, :start_date, :start_time, :stop_date, :stop_time, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :days

  before_validation :assign_day_of_week

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

  def number
    # This is the number of children signed up for this class
    scheduleregs.size
  end

  def number_confirmed
    # This is the number of children signed up for this class and confirmed (not on waitlist)
    scheduleregs.size - scheduleregs.where(:wait => 'Y').size
  end

  def check_days
    if %w(sunday monday tuesday wednesday thursday friday saturday).all?{|attr| self[attr].blank?}
      errors.add :base, "At least one day of the week must be selected"
      return false
    else
      return true
    end
  end

  def assign_day_of_week
    self.day_of_week = 7 if saturday?
    self.day_of_week = 6 if friday?
    self.day_of_week = 5 if thursday?
    self.day_of_week = 4 if wednesday?
    self.day_of_week = 3 if tuesday?
    self.day_of_week = 2 if monday?
    self.day_of_week = 1 if sunday?
  end


end