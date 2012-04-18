class HomeController < ApplicationController
	skip_before_filter :authenticate_user!

  def index
		if current_user
			redirect_to '/users/sign_in'
			return
		else
			respond_to do |format|
				format.html 
			end
		end
  end

	def ajax_index
		respond_to do |format|
			format.html {render :layout => false }
		end
  end

	def ajax_help
		respond_to do |format|
			format.html {render :layout => false }
		end
  end

	def email_send
		redirect_to '/users/sign_up?email=' + params[:home_email]
	end

end
