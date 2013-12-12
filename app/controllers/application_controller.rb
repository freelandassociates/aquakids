class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user
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
