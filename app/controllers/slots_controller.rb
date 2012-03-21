class SlotsController < ApplicationController
  # GET /slots
  # GET /slots.json
  def index
    @slots = Slot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slots }
    end
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
    @slot = Slot.find(params[:id])
		@shifts = Shift.find(:all, :conditions => {:slot_id => @slot.id})

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @slot }
    #end

		redirect_to :controller => "areas", :action => "show", :id => @slot.area_id
  end

  # GET /slots/new
  # GET /slots/new.json
  def new
    @slot = Slot.new
		session[:area_id] = params[:area_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slot }
			format.js
    end
  end

  # GET /slots/1/edit
  def edit
    @slot = Slot.find(params[:id])
		@shifts = Shift.find(:all, :conditions => {:slot_id => @slot.id})
		#@volunteers = @slot.area.village.event.volunteers
		@volunteers = Volunteer.valid_volunteers_for_area(@slot)
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(params[:slot])
		@slot.area_id = session[:area_id]

    respond_to do |format|
      if @slot.save
        format.html { redirect_to edit_slot_path(@slot), notice: 'Slot was successfully created.' }
        format.json { render json: @slot, status: :created, location: @slot }
				format.js
      else
        format.html { render action: "new" }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

	def import_shift_function
		slot = Slot.find(params[:id])
		slot.import_shift_list

		#respond_to do |format|
			#format.html {redirect_to edit_slot_path(slot.id)}
			redirect_to edit_slot_path(slot.id)
		#end
	end
  # PUT /slots/1
  # PUT /slots/1.json
  def update
    @slot = Slot.find(params[:id])

    respond_to do |format|
      if @slot.update_attributes(params[:slot])
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to village_path(@slot.area.village) }
      format.json { head :no_content }
    end
  end
end
