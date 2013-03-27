class StaticController < ApplicationController
  def home
  	@search = Schedule.search(params[:q])
  	@schedules = @search.result
  end
end
