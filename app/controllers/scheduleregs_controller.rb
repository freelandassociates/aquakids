class ScheduleregsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    @scheduleregs = Scheduleregs.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scheduleregs }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @schedulereg = Schedulereg.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedulereg }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @schedulereg = Schedulereg.new
    @schedulereg.schedule_id = (params[:schedule_id])
    @schedule = Schedule.find(params[:schedule_id])
    @schedulereg.entry_date = @schedule.start_date
    @schedulereg.exit_date = @schedule.stop_date
    @schedulereg.location_id = @schedule.location_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedulereg }
    end
  end

  # GET /registrations/1/edit
  def edit
    @schedulereg = Schedulereg.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create

    # Make a new errors hash
    @errors = Hash.new 

    # Create schedulereg object from parameters (and hidden field schedule Id?)
    @schedulereg = Schedulereg.new
    @schedulereg.child_id = params[:schedulereg][:child_id]
    @schedulereg.schedule_id = params[:schedulereg][:current_schedule_id]
    @schedulereg.location_id = params[:schedulereg][:location_id]
    @schedulereg.entry_date = params[:schedulereg][:entry_date]
    @schedulereg.exit_date = params[:schedulereg][:exit_date]
    @schedulereg.referral_id = params[:schedulereg][:referral_id]
    @schedulereg.referred_by = params[:schedulereg][:referred_by]
    @schedule = Schedule.find(params[:schedulereg][:current_schedule_id])
    # if number of children already signed up is equal to or greater than the class
    #   capacity, set the "wait" flag to yes..
    # binding.pry
    if @schedule.number >= @schedule.size
      @schedulereg.wait = 'Y'
    end  

    # Check if schedulereg object is valid and if not, add errors as json to errors hash
    if (@schedulereg.invalid?)
      @errors = @schedulereg.errors.as_json
      # if (!params[:schedulereg][:child_id].blank?)
      #   @errors = @errors.except!(:child_id)
      # end
    end
    # binding.pry

    # If parent Id is blank
    if (params[:schedulereg][:parent_id].blank?)
      
      # Create new parent from parameters
      @parent = Parent.new
      @parent.first_name = params[:schedulereg][:parent_first_name]
      @parent.last_name = params[:schedulereg][:parent_last_name]
      @parent.address_1 = params[:schedulereg][:parent_address_1]
      @parent.address_2 = params[:schedulereg][:parent_address_2]
      @parent.city = params[:schedulereg][:parent_city]
      @parent.state = params[:schedulereg][:parent_state]
      @parent.zip = params[:schedulereg][:parent_zip]
      @parent.home_phone = params[:schedulereg][:parent_home_phone]
      @parent.cell_phone = params[:schedulereg][:parent_cell_phone]

      # Check if parent is valid and if not, add errors as json to error hash
      if (@parent.invalid?)
        @parent_errors = Hash[@parent.errors.map{|k,v| ["parent_#{k}",v]}]
        @errors = @errors.merge(@parent_errors.as_json)
      end

    end

    # If child Id is blank 
    if (params[:schedulereg][:child_id].blank?)

      # Create new child from parameters
      @child = Child.new
      @child.first_name = params[:schedulereg][:child_first_name]
      @child.last_name = params[:schedulereg][:child_last_name]
      @child.date_of_birth = params[:schedulereg][:child_date_of_birth]
      @child.notes = params[:schedulereg][:child_notes]
      @child.parent_id = params[:schedulereg][:parent_id]
      
      # Check child is valid and if not, add errors as json to error hash. 
      if (@child.invalid?)
        # @child_errors = @child.errors.except!(:parent_id)
        @ch_errors = @child.errors.as_json
        @ch_errors = @ch_errors.except!(:parent_id)

        @child_errors = Hash[@ch_errors.map{|k,v| ["child_#{k}",v]}]
        @errors = @errors.merge(@child_errors.as_json)

        # If errors hash contains child-parent-id, map back to parent-Id
        # mappings = {"child_parent_id" => "parent_id"}
        # @errors.keys.each { |k| @errors[ mappings[k] ] = @errors.delete(k) if mappings[k] }
      end

      # Remove parent_id and child_id errors..
      @errors = @errors.except!(:child_id)

    end

    #@errors = @errors.except!(:parent_id)

    
    # If errors hash is empty
    if (@errors.empty?) 
      
      # If parent Id is blank, save the parent..
      if (params[:schedulereg][:parent_id].blank?)
        @parent.save
        params[:schedulereg][:parent_id] = @parent.id
        flash[:notice] = "Successfully created parent."
      end

      # If child id is blank, save the child..
      if (params[:schedulereg][:child_id].blank?)
        # @child.parent_id = @parent.id
        @child.parent_id = params[:schedulereg][:parent_id]
        @child.save
        @schedulereg.child_id = @child.id
        flash[:notice] = "Successfully created child."
      end
      
      # Save the schedulereg
      @schedulereg.save
      flash[:notice] = "Successfully registered."

      # Add flash notices to response header
      response.headers['x-flash'] = flash[:notice]  unless flash[:notice].blank?
      # flash.discard
    
      # Send json back with errors hash
      respond_to do |format|
        format.js   { render json: @errors, status: :ok }
      end      
    
    else
      
      # Send json back with errors hash
      respond_to do |format|
        format.js   { render json: @errors, status: :unprocessable_entity }
      end

    end

  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @schedulereg = Schedulereg.find(params[:id])

    respond_to do |format|
      if @schedulereg.update_attributes(params[:schedulereg])
        format.html { redirect_to @schedulereg, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedulereg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end

  def registrations_by_schedule
    # @schedules = Schedule.all
    # @search = Schedule.search(params[:q])
    #@search = Schedule.search(:id_eq => 0)
    # @schedules = @search.result.order('start_date, start_time')

    @schedule = (params[:schedule_id])
    # @registrations = Registration.find_by schedule_id: @schedule
    @scheduleregs = Schedulereg.where("schedule_id = ?", @schedule)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scheduleregs, root: false, :each_serializer => ScheduleregSerializer }
    end
  end

  def refresh_flash
    render :partial => "layouts/flashmessages"
  end

end
