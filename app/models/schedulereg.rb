class Schedulereg < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :schedule
  belongs_to :child
  # belongs_to :parent
  belongs_to :location
  belongs_to :referral
  belongs_to :skill
  belongs_to :level
  has_many :attainments
  # has_many :skills, :through => :attainments

  attr_accessible :comments, :entry_date, :exit_date, :child_id, :referral_id, :referred_by, :schedule_id, :location_id
  
  validates_uniqueness_of :child_id, scope: :schedule_id, message: "already registered for this class"

  validates_presence_of :entry_date, :exit_date, :child_id

  validates_date :entry_date, :on_or_before => :exit_date,
                              :on_or_before_message => "Entry date can not be after exit date"

  validates_date :exit_date

  after_save :calculate_spaces

  def calculate_spaces
    # schedule.spaces = schedule.size - schedule.number_confirmed
    # if schedule.number = 0
    #   schedule.capacity = 'E'
    # elsif schedule.number >= schedule.size
    #   schedule.capacity = 'F'
    # else
    #   schedule.capacity = 'P'
    # end
    schedule.save
  end

end
