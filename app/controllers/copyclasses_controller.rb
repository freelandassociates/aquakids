class CopyclassesController < ApplicationController

  def copy_classes
    @schedules = Schedule.find(params[:schedule_ids])
    @copyclass = Copyclass.new
    @copyclass.date_offset = 0
    @copyclass.time_offset = 0
  end

  def copy_classes_update
    @schedules = params[:schedule_ids]
    @copyclass = Copyclass.new(params[:copyclass])
    if @copyclass.valid?
      logger.info "***** VALID ******"
      i = params[:schedule_ids].size
      redirect_to schedules_path, :notice => "#{i} new class(es) copied."    
    else
      logger.info "***** INVALID ******"
      @schedules = Schedule.find(params[:schedule_ids])
      @copyclass.program = params[:copyclass][:program]
      @copyclass.date_offset = params[:copyclass][:date_offset]
      @copyclass.time_offset = params[:copyclass][:time_offset]
      render :copy_classes   
    end

  end

  # def create_schedules
  #   # Loop for a maximum number of times as defined in max_classes parameter
  #   @autoclass = Autoclass.new(params[:autoclass])
  #   if @autoclass.valid?
  #     # Loop for as many times specified in max classes..
  #     for i in 1..@autoclass.max_classes.to_i do
  #       # Create a new Schedule object
  #       @schedule = Schedule.new
  #       @schedule.day_of_week=@autoclass.day_of_week
  #       @schedule.size=@autoclass.size
  #       @schedule.start_date=@autoclass.start_date
  #       @schedule.start_time=@autoclass.start_at_time
  #       @schedule.start_time=@schedule.start_time + (@autoclass.class_length.to_i * (i - 1) * 60)
  #       @schedule.stop_date=@autoclass.stop_date
  #       @schedule.stop_time=@schedule.start_time + (@autoclass.class_length.to_i * 60)
  #       @schedule.level_id=@autoclass.level_id
  #       @schedule.activity_id=@autoclass.activity_id
  #       @schedule.type_id=@autoclass.type_id
  #       @schedule.program_id=@autoclass.program_id
  #       @schedule.teacher_id=@autoclass.teacher_id
  #       @schedule.location_id=@autoclass.location_id
  #       @schedule.facility_id=@autoclass.facility_id
  #       @schedule.zone_id=@autoclass.zone_id

  #       # If calculated end time is less than stop by time, save the schedule object
  #       if @schedule.stop_time.strftime('%H:%M') <= @autoclass.stop_by_time
  #         if @schedule.save
  #           logger.info "CREATED: #{@schedule.attributes}"
  #         else
  #           logger.debug "ERRORS: #{@schedule.errors.messages}"
  #         end
  #       else
  #       # Otherwise, quit the loop and stop writing schedules
  #         i = i - 1
  #         break
  #       end
  #     end
  #     # Redirect back to schedule page
  #     redirect_to schedules_path, :notice => "#{i} new schedule(s) created."
  #   else
  #     render :autoclass
  #   end

  # end

end
