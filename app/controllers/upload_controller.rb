class UploadController < ApplicationController

	def index
		respond_to do |format|
			format.html {render :layout => false}
		end
	end

	def create 
		DataFile.save(params[:upload])
		render :text => "File has been uploaded"
	end
end
