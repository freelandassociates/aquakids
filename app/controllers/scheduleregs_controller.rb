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
    @schedulereg = Schedulereg.new(params[:schedulereg])

    respond_to do |format|
      if @schedulereg.save
        # format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.html { redirect_to schedules_path, notice: 'Registration was successfully created.' }
        format.js   { render json: @schedulereg, status: :ok}
        format.json { render json: @schedulereg, status: :created, location: @schedulereg }
      else
        # binding.pry
        format.html { render action: "new" }
        # Respond with JSON to an AJAX request.
        format.js   { render json: @schedulereg.errors, status: :unprocessable_entity }
        format.json { render json: @schedulereg.errors, status: :unprocessable_entity }
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

end
