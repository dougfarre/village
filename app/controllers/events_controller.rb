class EventsController < ApplicationController

	def maintain
		event = Event.find(params[:event_id])
		volunteer_event_ids = params[:selected_volunteers]

		if params[:commit] == "Remove" 
			volunteer_event_ids.each do |volunteer_event_id|
				volunteer_event = VolunteerEvent.find(volunteer_event_id)
				volunteer_event.destroy
			end
		elsif params[:commit] == "Save" 
			area_ids = params[:areas]		
			volunteer_event_ids.each do |volunteer_event_id|
				volunteer_event = VolunteerEvent.find(volunteer_event_id)
				volunteer = volunteer_event.volunteer
				shifts = params['shift_' + volunteer_event.id.to_s] 	
				new_areas = Array.new()

				area_ids.each do |area_id|
					unless area_id.scan(volunteer_event_id.to_s + '_').blank?	
						new_areas.push(area_id.split('_')[1])		
					end
				end

				volunteer_event.required_shifts = shifts	
				volunteer_event.area_ids = new_areas 
				volunteer_event.save!
			end
		elsif params[:commit] == "Send Email Alerts"
			session[:volunteer_event_ids] = volunteer_event_ids 
			session[:medium] = 'email'
			redirect_to volunteer_emailer_path(:event_id => event.id)	
			return
		elsif params[:commit] == "Send SMS Alerts"
			session[:volunteer_event_ids] = volunteer_event_ids 
			session[:medium] = 'sms'
			redirect_to volunteer_emailer_path(:event_id => event.id)	
			return
		end

		respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
	end

  # GET /events
  # GET /events.json
  def index
    @events = Event.find(:all, :conditions => {:user_id => current_user.id})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
		session[:event_id] = @event.id
		@villages = Village.find(:all, :conditions => {:event_id => @event.id})
		@volunteer_events = VolunteerEvent.find(:all, :conditions => {:event_id => @event.id})
		@volunteers = @event.volunteers

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html { render :layout => false }# new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
		render :layout => false
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
		@event.update_attributes(:user_id => current_user.id)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
