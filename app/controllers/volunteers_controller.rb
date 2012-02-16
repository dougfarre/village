class VolunteersController < ApplicationController

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

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volunteers }
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
		@event_id = params[:event_id]
		session[:stored_event_id] = @event_id
    @volunteer = Volunteer.new

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
		@event = Event.find(session[:stored_event_id].to_i)
		session[:stored_event_id] = @event.id
    @volunteer = Volunteer.new(params[:volunteer])
		@event.volunteers << @volunteer	

    respond_to do |format|

      if @volunteer.save
        format.html { redirect_to event_path(@event), notice: 'Volunteer was successfully created.' }
        format.json { render json: @volunteer, status: :created, location: @volunteer }

      else
        format.html { render action: "new" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
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
        format.html { redirect_to event_path(event_id), notice: 'Volunteer was successfully updated.' }
        format.json { head :no_content }
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
