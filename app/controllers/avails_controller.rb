class AvailsController < ApplicationController


	def save_volunteers_to_area
		volunteer = current_user.volunteer
		volunteer_event = VolunteerEvent.find(params[:volunteer_event_id])
		area_ids = params[:areas]		
		volunteer_event.areas.delete_all

		volunteer_event.area_ids = area_ids
		volunteer_event.save!

		respond_to do |format|
      format.html { redirect_to availability_path(:event_id => params[:event_id]), :method => 'get',  :notice => "Availability saved!"}
    end

	end


  # GET /avails/1, GET /avails/1.json
  def show
    @avail = Avail.find(params[:id])

    respond_to do |format|
      format.html { render  :layout => false }
      format.json { render json: @avail }
    end
  end


  # GET /avails/new, GET /avails/new.json
  def new
   @avail = Avail.new
	 session[:event_id] = params[:event_id]
	 session[:current_date] = params[:current_date]

   respond_to do |format|
   	format.html { render :layout => false }
    format.json { render json: @avail }
    end
  end


  # GET /avails/1/edit
  def edit
    @avail = Avail.find(params[:id])
		
		respond_to do |format|
			format.html { render :layout => false }
		end
  end


  # POST /avails, POST /avails.json
  def create
 		@volunteer_event = VolunteerEvent.find(:first, :conditions =>
											 {:event_id => session[:event_id],
											  :volunteer_id => current_user.volunteer.id})
    @avail = @volunteer_event.avails.build(params[:avail])
	 	@avail.event_date = Date.parse(session[:current_date])

    respond_to do |format|
      if @avail.save
        format.html { redirect_to availability_path(:event_id => session[:event_id]), 
											notice: 'Avail was successfully created.' }
        format.json { render json: @avail, 
											status: :created, location: @avail }
      else
        format.html { render action: "new" }
        format.json { render json: @avail.errors, 
											status: :unprocessable_entity }
      end
    end
  end


  # PUT /avails/1, PUT /avails/1.json
 def update
    @avail = Avail.find(params[:id])

    respond_to do |format|
      if @avail.update_attributes(params[:avail])
        format.html { redirect_to :back,
											notice: 'Avail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @avail.errors,
											status: :unprocessable_entity }
      end
    end
  end


  # DELETE /avails/1, DELETE /avails/1.json
  def destroy
    @avail = Avail.find(params[:id])
    @avail.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
