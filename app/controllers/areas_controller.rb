class AreasController < ApplicationController


	def get_areas
		@volunteer_event = VolunteerEvent.find(params[:volunteer_event_id])
		village = Village.find(params[:village_id])
		@areas = village.areas
		temp_s = ''
	
		respond_to do |format|
			format.html { render :layout => false } 
		end
	end


  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
		redirect_to @area.village
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
		#@area.update_attributes(:village_id => params[:village_id])
		session[:village_id] = params[:village_id]

    respond_to do |format|
      format.html {render :layout => false}# new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
		render :layout => false
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])
		@area.village_id = session[:village_id] 

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' } 
				format.json { render json: @area, status: :created, location: @area } 
			else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
