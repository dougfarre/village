class HomeController < ApplicationController
	skip_before_filter :authenticate_user!

  def index
		respond_to do |format|
			format.html {render :layout => 'home_layout' }
		end
  end

	def ajax_index
		respond_to do |format|
			format.html {render :layout => false }
		end
  end

	def email_send
		redirect_to '/users/sign_up?email=' + params[:home_email]
	end

end
