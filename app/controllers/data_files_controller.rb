class DataFilesController < ApplicationController
# respond_to :js, :only => [:create]

	def index
		event_id = 0

		if params[:event_id].blank?
			event_id = session[:stored_event_id].to_i
		else
			event_id = params[:event_id]
		end

		@files = Event.find(event_id).data_files
		session[:stored_session_id] = event_id	

		respond_to do |format|
			format.html
		end
	end

	def	show
    file_wrapper = DataFile.find(params[:id])
		Volunteer.csv_import(file_wrapper, session[:stored_session_id].to_i)

		respond_to do |format|
			format.html {render 'show', :layout => false}
		end
	end	

	def new
		@event_id = params[:event_id]
		session[:stored_event_id] = @event_id
    @file = DataFile.new
		
		respond_to do |format|
			format.html {render :layout => false}
		end
	end

	def create
		@event = Event.find(session[:stored_event_id].to_i)
		session[:stored_event_id] = @event.id
    @file = @event.data_files.build(params[:data_file])

    respond_to do |format|
    	if @file.save
 	   		format.html { redirect_to data_files_path } #(@event_id)}
	   		format.json { render json: @file, status: :created, location: @file }
				# format.js
    	else
     		format.html { render action: "new" }
     		format.json { render json: @file.errors, status: :unprocessable_entity }
    	end
    end
  end
end
