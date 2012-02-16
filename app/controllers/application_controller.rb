class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :authenticate_user!

	def after_sign_in_path_for(resource)
		return request.env['omniauth.origin'] || events_path || root_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end
end
