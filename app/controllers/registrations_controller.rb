class RegistrationsController < ApplicationController


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
