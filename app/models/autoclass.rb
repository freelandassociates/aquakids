class Autoclass
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # attr_accessor :comments, :day_of_week, :size, :start_date, :stop_date, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id, :max_classes, :start_at_time, :class_length, :stop_by_time
  attr_accessor :comments, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :size, :start_date, :stop_date, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id, :max_classes, :start_at_time, :class_length, :stop_by_time

  # validates_presence_of :day_of_week, :size, :start_date, :stop_date, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id, :max_classes, :start_at_time, :class_length, :stop_by_time
  validates_presence_of :size, :start_date, :stop_date, :level_id, :activity_id, :type_id, :program_id, :teacher_id, :location_id, :facility_id, :zone_id, :max_classes, :start_at_time, :class_length, :stop_by_time

  validates :max_classes, :numericality => { :only_integer => true }
  validates :size, :numericality => { :only_integer => true, :less_than_or_equal_to => 10 }
  validates :class_length, :numericality => { :only_integer => true }

  validates_date :start_date, :on_or_before => :stop_date,
                              :on_or_before_message => "Start date can not be after stop date"

  validates_date :stop_date

  validates_time :start_at_time, :before => :stop_by_time,
                                 :before_message => "Start at time must be before stop by time"

  validates_time :stop_by_time

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end