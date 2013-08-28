class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new
    @registration.schedule_id = (params[:schedule_id])
    @schedule = Schedule.find(params[:schedule_id])
    @registration.entry_date = @schedule.start_date
    @registration.exit_date = @schedule.stop_date
    @registration.location_id = @schedule.location_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
        # format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.html { redirect_to schedules_path, notice: 'Registration was successfully created.' }
        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        format.js   { render json: @registration.errors, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
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
    @registrations = Registration.where("schedule_id = ?", @schedule)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations, root: false, :each_serializer => RegistrationSerializer }
    end
  end

end
