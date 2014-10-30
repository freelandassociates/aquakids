class SchedulesController < ApplicationController
  filter_access_to :all
  filter_access_to :ransack_read_only_search, :require => :show
  filter_access_to :ransack_search, :require => :show
  filter_access_to :delete_many, :require => :destroy

  # GET /schedules
  # GET /schedules.json
  def index
    @search = Schedule.search(params[:q])
    @schedules = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules, root: false, :each_serializer => ScheduleReadOnlySerializer }
    end
  end

  def ransack_read_only_search
    # @schedules = Schedule.all
    # binding.pry
    if (params[:q]["capacity_in"].include? 'P')
      params[:q]["capacity_in"] = params[:q]["capacity_in"] | ["E"]
    end
    # binding.pry
    @search = Schedule.search(params[:q])
    #@search = Schedule.search(:id_eq => 0)
    @schedules = @search.result.order('start_date, start_time')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules, root: false, :each_serializer => ScheduleReadOnlySerializer }
    end
  end


  def classes
    @search = Schedule.search(params[:q])
    @schedules = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules, root: false}
    end
  end

  def ransack_search
    # @schedules = Schedule.all
    if (params[:q]["capacity_in"].include? 'P')
      params[:q]["capacity_in"] = params[:q]["capacity_in"] | ["E"]
    end
    @search = Schedule.search(params[:q])
    #@search = Schedule.search(:id_eq => 0)
    @schedules = @search.result.order('start_date, start_time')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules, root: false }
    end
  end


  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule, root: false, :serializer => ScheduleReadOnlySerializer }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(params[:schedule])
    # @schedule.start_time = Time.zone.parse(params[:schedule][:start_time])
    # @schedule.stop_time = Time.zone.parse(params[:schedule][:stop_time])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedules_url, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id])
    # binding.pry 
    # set start_time and stop_time parameters to correct db time format
    params[:schedule][:start_time] = DateTime.parse(params[:schedule][:start_time]).to_time
    params[:schedule][:stop_time] = DateTime.parse(params[:schedule][:stop_time]).to_time
    # logger.info "START_TIME: #{params[:schedule][:start_time]}"
    # logger.info "STOP_TIME: #{params[:schedule][:stop_time]}"
    # logger.info "#{Time.zone.utc_offset}"
    params[:schedule][:start_date] = DateTime.parse(params[:schedule][:start_date]).to_date
    params[:schedule][:stop_date] = DateTime.parse(params[:schedule][:stop_date]).to_date
    
    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to schedules_url, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end

  def delete_many
    # binding.pry
    Schedule.destroy(params[:schedule_ids])
  end

end
