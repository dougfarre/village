class ShiftsController < ApplicationController
  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @shift = Shift.find(params[:id])
		@volunteers = Volunteer.valid_volunteers_for_area(@slot)
		#@volunteers = @shift.slot.area.village.event.volunteers
		# @slots = Slot.find(:all, :conditions => {:area_id => @area.id})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/new
  # GET /shifts/new.json
  def new
    @shift = Shift.new
		@slot = Slot.find(params[:slot_id])
		session[:slot_id] = @slot.id

		@volunteers = Volunteer.valid_volunteers_for_area(@slot)

    respond_to do |format|
      format.html { render :layout => false } # new.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/1/edit
  def edit
    @shift = Shift.find(params[:id])
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(params[:shift])
		@shift.slot_id = session[:slot_id]

    respond_to do |format|
      if @shift.save
        format.html { redirect_to edit_slot_path(session[:slot_id]), notice: 'Shift was successfully created.' }
        format.json { render json: @shift, status: :created, location: @shift }
      else
        format.html { redirect_to edit_slot_path(session[:slot_id]), notice: 'Cannot save, the Volunteer is already registered for this slot.' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    @shift = Shift.find(params[:id])

    respond_to do |format|
      if @shift.update_attributes(params[:shift])
        format.html { redirect_to edit_slot_path(@shift.slot_id), notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_slot_path(session[:slot_id]), notice: "Cannot save, the Volunteer is already registered for this slot" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to edit_slot_path(@shift.slot_id) }
      format.json { head :no_content }
    end
  end
end
