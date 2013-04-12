class AutoclassesController < ApplicationController

  def autoclass
    @autoclass = Autoclass.new
    @autoclass.start_at_time = Time.now
  end

  def create_schedules
    # Loop for a maximum number of times as defined in max_classes parameter
    @autoclass = Autoclass.new(params[:autoclass])
    #@max_classes = params[:autoclass][:max_classes]
    binding.pry
    if @autoclass.valid?
      # Updating stuff goes here..
      logger.info "********** UPDATING..."
      # Loop for as many times specified in max classes..
      for i in 1..@autoclass[:max_classes].to_i
        # Create a new Schedule object
        @schedule = Schedule.new(@autoclass)
        binding.pry
        # Set start and end times
        # Set teacher
        # If calculated end time is less than stop by time, save the schedule object
        #   if @schedule.save
        #     logger.info "CREATED: #{@schedule.attributes}"
        #   else
        #     logger.debug "ERRORS: #{@schedule.errors.messages}"
        #   end
        # Otherwise, quit the loop and stop writing schedules
        # Redirect back to schedule page
        redirect_to zschedules_path, :notice => "#{i} new schedules created.."
      end
    else
      logger.info "********** RENDERING..."
      render :autoclass
    end
    # if @max_classes.to_i > 15
    #   render action: "autoclass"
    # end
    # for i in 1..@max_classes.to_i
    #   # Create a new Schedule object
    #   @schedule = Schedule.new(params[:schedule])
    #   # Set start and end times
    #   # If end time is less than stop_by time then save schedule,
    #   if @schedule.save
    #     logger.info "CREATED: #{@schedule.attributes}"
    #   else
    #     logger.debug "ERRORS: #{@schedule.errors.messages}"
    #   end 
    #   # otherwise, quit the loop..
    #   # if i > 2 then
    #   #   break
    #   # end
    # end
    # @max_classes = params[:schedule][:max_classes]
    #logger.info "Creating schedules"
    #logger.debug "Max Classes: #{@max_classes}"
    #redirect_to zschedules_path, :notice => "#{@max_classes} schedules created.."
  end

end
