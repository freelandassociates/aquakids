class AutoclassesController < ApplicationController

  def autoclass
    @autoclass = Autoclass.new
  end

  def create_schedules
    # Loop for a maximum number of times as defined in max_classes parameter
    @autoclass = Autoclass.new(params[:autoclass])
    if @autoclass.valid?
      # Updating stuff goes here..
      logger.info "********** UPDATING..."
      # Loop for as many times specified in max classes..
      for i in 1..@autoclass.max_classes.to_i do
        # Create a new Schedule object
        @schedule = Schedule.new
        @schedule.day_of_week=@autoclass.day_of_week
        @schedule.size=@autoclass.size
        @schedule.start_date=@autoclass.start_date
        @schedule.start_time=@autoclass.start_at_time
        @schedule.start_time=@schedule.start_time + (@autoclass.class_length.to_i * (i - 1) * 60)
        @schedule.stop_date=@autoclass.stop_date
        @schedule.stop_time=@schedule.start_time + (@autoclass.class_length.to_i * 60)
        @schedule.level_id=@autoclass.level_id
        @schedule.activity_id=@autoclass.activity_id
        @schedule.type_id=@autoclass.type_id
        @schedule.program_id=@autoclass.program_id
        @schedule.teacher_id=@autoclass.teacher_id
        @schedule.location_id=@autoclass.location_id
        @schedule.facility_id=@autoclass.facility_id
        @schedule.zone_id=@autoclass.zone_id

        # If calculated end time is less than stop by time, save the schedule object
        if @schedule.stop_time.strftime('%H:%M') <= @autoclass.stop_by_time
          if @schedule.save
            logger.info "CREATED: #{@schedule.attributes}"
          else
            logger.debug "ERRORS: #{@schedule.errors.messages}"
          end
        else
        # Otherwise, quit the loop and stop writing schedules
          i = i - 1
          break
        end
      end
      # Redirect back to schedule page
      redirect_to schedules_path, :notice => "#{i} new schedules created.."
    else
      logger.info "********** RENDERING..."
      render :autoclass
    end

  end

end
