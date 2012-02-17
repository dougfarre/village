class VolunteersController < ApplicationController

	def availability
		@volunteer = current_user.volunteer
		@event = Event.find(params[:event_id])
		@avails = @volunteer.volunteer_events.find(:first,
							:conditions => {:event_id => @event.id}).avails

		@villages = @event.villages
		@num_days = (@event.end_date - @event.start_date).to_i
	
		@avails_array = Array.new

		(0 .. @num_days).each do |i|
			j = ActiveSupport::JSON
			temp = @avails.find(:all, 
											 :conditions => {
											 :event_date => @event.start_date + i})
			@avails_array << (j.encode(temp))
		end		

		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

	def volunteer_dashboard
		@user = current_user
		@volunteer = @user.volunteer
		@events = @volunteer.events

		respond_to do |format|
			format.html
		end
	end

	def volunteer_mixer
		@event = Event.find(params[:event_id])
		@volunteers = Volunteer.find(:all)
		session[:event_id] = @event.id	

		respond_to do |format|
			format.html
		end
	end

	def save_volunteers
		event = Event.find(session[:event_id])
		event.volunteer_ids = params[:volunteers] + event.volunteer_ids
		event.save

		respond_to do |format|
      format.html { redirect_to event_path(event.id) }
      format.json { head :no_content }
    end
	end

	def associate_event
		event = Event.find(params[:event_id].to_i)

		unless event.volunteers.include?(current_user.volunteer)
			event.volunteers << current_user.volunteer
		end

		event.save

		respond_to do |format|
      format.html { redirect_to volunteer_dashboard_path }
      format.json { head :no_content }
    end
	end

  # GET /volunteers
  # GET /volunteers.json
=begin
  def index
    @volunteers = Volunteer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volunteers }
    end
  end
=end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
		if current_user.user_type == 'organizer'
			@event_id = params[:event_id]
			session[:stored_event_id] = @event_id
    	@volunteer = Volunteer.new
		else
    	@volunteer = Volunteer.new
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
		if current_user.user_type == 'organizer'
			session[:stored_event_id] = @event.id
			@event = Event.find(session[:stored_event_id].to_i)
    	@volunteer = Volunteer.new(params[:volunteer])
			@event.volunteers << @volunteer	

    	respond_to do |format|
      	if @volunteer.save
        	format.html { redirect_to event_path(@event), 
												notice: 'Volunteer was successfully created.' }
        	format.json { render json: @volunteer, 
												status: :created, 
												location: @volunteer }
      	else
        	format.html { render action: "new" }
        	format.json { render json: @volunteer.errors, 
												status: :unprocessable_entity }
      	end
    	end
		else
    	@volunteer = Volunteer.new(params[:volunteer])
			@volunteer.user = current_user

    	respond_to do |format|
      	if @volunteer.save
        	format.html { redirect_to volunteer_dashboard_path ,
												notice: 'Your information was successfully created.' }
        	format.json { render json: @volunteer, 
												status: :created, 
												location: @volunteer }
      	else
        	format.html { render action: "new" }
        	format.json { render json: @volunteer.errors, 
												status: :unprocessable_entity }
      	end
    	end

		end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
		event_id = session[:stored_event_id]
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
				if current_user.user_type == 'organizer'
        	format.html { redirect_to event_path(event_id), 
												notice: 'Volunteer was successfully updated.' }
        	format.json { head :no_content }
				else
					format.html { redirect_to volunteer_dashboard_path, 
												notice: 'Your information was successfully updated.' }
        	format.json { head :no_content }
				end
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy

    respond_to do |format|
      format.html { redirect_to event_path(session[:event_id]) }
      format.json { head :no_content }
    end
  end
end
