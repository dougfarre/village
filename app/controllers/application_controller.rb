class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :authenticate_user!

	def after_sign_in_path_for(resource)
		if current_user.user_type == 'organizer'
			return request.env['omniauth.origin'] || events_path || root_path
		elsif current_user.volunteer.blank?
			return new_volunteer_path
	  else
			return volunteer_dashboard_path
		end
	end

	def after_sign_out_path_for(resource)
		root_path
	end
end
