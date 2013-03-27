class ApplicationController < ActionController::Base
  protect_from_forgery

  # def after_sign_in_path_for(user)
 	# root_url
  # end

  before_filter :set_current_user
	protected
	def set_current_user
	  Authorization.current_user = current_user
	end

end
