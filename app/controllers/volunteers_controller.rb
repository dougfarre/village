class VolunteersController < ApplicationController

	def emailer
		@event = Event.find(params[:event_id])
		@medium = session[:medium]
		session[:event_id] = @event.id
		session[:medium] = @medium 
		session[:volutneer_event_ids] = session[:volunteer_event_ids]
		@volunteer_event_ids = session[:volunteer_event_ids]

		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
	end
	
	def send_emailer
		medium = session[:medium]
		message = params[:message]
		subject = params[:subject]
		volunteer_event_ids = session[:volunteer_event_ids]

		if medium == 'email'
			volunteer_event_ids.each do |volunteer_event_id|
				begin
					volunteer_event = VolunteerEvent.find(volunteer_event_id)
					UserMailer.aux_alert(volunteer_event.get_email, message, subject).deliver
				rescue
				end
			end
		else
			volunteer_event_ids.each do |volunteer_event_id|
				volunteer_event = VolunteerEvent.find(volunteer_event_id)
				if volunteer_event.has_volunteer
					volunteer_event.volunteer.send_sms_message(message)
				end
			end
		end

		redirect_to event_path(session[:event_id], :notice => "Email updates sent!")	
	end 


	def availability
		@volunteer = current_user.volunteer
		@event = Event.find(params[:event_id])
		@volunteer_event = @volunteer.volunteer_events.find(:first,
												:conditions => {:event_id => @event.id})
		@avails = @volunteer_event.avails

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

		params[:volunteers].each do |new_volunteer_id|	
			if !(event.volunteer_ids.include? new_volunteer_id.to_i)
				new_volunteer = Volunteer.find(new_volunteer_id.to_i) 
		 		event.volunteers << new_volunteer
				UserMailer.add_alert(new_volunteer, event).deliver!
			end
		end

		event.save

		respond_to do |format|
      format.html { redirect_to event_path(event.id) }
      format.json { head :no_content }
    end
	end

	def associate_event
		begin
			event = Event.find(params[:event_id].to_i)
		rescue
			flash[:message] = 'Event does not exist.'
			redirect_to volunteer_dashboard_path 
			return
		end
		
		unless event.volunteers.include?(current_user.volunteer)
			event.volunteers << current_user.volunteer
		end

		event.save

		respond_to do |format|
      format.html { redirect_to volunteer_dashboard_path }
      format.json { head :no_content }
    end
	end

	def unassociate_event
		event = Event.find(params[:event_id].to_i)

		begin
			volunteer = Volunteer.find(params[:volunteer_id].to_i)
			volunteer_event = VolunteerEvent.find(:first, :conditions => {:event_id => event.id, :volunteer_id => volunteer.id})
			volunteer_event.destroy

		rescue
			volunteer_event = VolunteerEvent.find(params[:volunteer_e])
			volunteer_event.destroy
		end

		respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
	end

	
	def volunteer_invite
		session[:event_id] = params[:event_id]

		respond_to do |format|
			format.html {render :layout => false }
		end
	end


	def save_volunteer_invite
		begin
			event = Event.find(session[:event_id])
			emails = params[:emails].split(",").map(&:strip).reject(&:empty?)

			emails.each do |email|
				volunteer = Volunteer.find(:first, :conditions => {:email => email})
			
				#volunteer does not exist
				if volunteer.blank?
					unless VolunteerEvent.exists?(:email => email, :event_id => event.id)
						v_event = VolunteerEvent.new(:event_id => event.id, :email => email)
						v_event.save
						UserMailer.registration_alert(email, event).deliver
					end
				#volunteer exists
				else 
					v_event = VolunteerEvent.find(:first,	
																				:conditions => {:event_id => event.id,
																	    	:volunteer_id => volunteer.id})
					#volutneer event does not exist	
					if v_event.blank?
						volunteer.events << event
						volunteer.save
						UserMailer.add_alert(volunteer, event).deliver!
					#volunteer does exist
					else 
						puts "#{volunteer.email} already exists"
					end
				end
			end #end of emails.each

			respond_to do |format|
      	format.html { redirect_to event_path(session[:event_id]), 
											:notice => "Volunteers have been invited." }
      	format.json { head :no_content }
    	end

		rescue
			respond_to do |format|
      	format.html { redirect_to :back, 
											:notice => "Save failed, incorrect format." }
      	format.json { head :no_content }
    	end
		end
	end

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
			session[:event_id] = @event_id
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
			session[:event_id] = @event.id
			@event = Event.find(session[:event_id].to_i)
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
			
			if !@volunteer.save
				respond_to do |format|
					format.html { render action: "new" }
        	format.json { render json: @volunteer.errors, 
												status: :unprocessable_entity }
				end
				return
			end

			v_events = VolunteerEvent.find(:all, :conditions => {:email => @volunteer.email})
			v_events.each do |v_event|
				v_event.volunteer = @volunteer
				v_event.save
			end

    	respond_to do |format|
       	format.html { redirect_to volunteer_dashboard_path ,
											notice: 'Your information was successfully created.' }
       	format.json { render json: @volunteer, status: :created, 
											location: @volunteer }
    	end
		end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
		event_id = session[:event_id]
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
