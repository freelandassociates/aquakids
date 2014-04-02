class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user
  
  # after_filter :add_flash_to_header

  # def add_flash_to_header
  #   # only run this in case it's an Ajax request.
  #   return unless request.xhr?
 
  #   # add different flashes to header
  #   response.headers['X-Flash-Error'] = flash[:error] unless flash[:error].blank?
  #   response.headers['X-Flash-Warning'] = flash[:warning] unless flash[:warning].blank?
  #   response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
  #   response.headers['X-Flash-Message'] = flash[:message] unless flash[:message].blank?
 
  #   # make sure flash does not appear on the next page
  #   # flash.discard
  # end

	protected
	def set_current_user
	  Authorization.current_user = current_user
	end

  def after_sign_in_path_for(user)
  	root_path
  end

  def after_sign_out_path_for(user)
    root_path 
  end

  def user_for_paper_trail
    current_user
  end

around_filter :scope_current_location

  def current_location # Returns Location object of current user
    current_user.location if current_user
  end
  helper_method :current_location

  def scope_current_location
    User.current = current_user
    yield
  ensure
    Location.current_id = nil    
  end

end
