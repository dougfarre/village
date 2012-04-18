class AvailsController < ApplicationController

	def shift_notice(slot, red)
		shift_time = slot.start_time.strftime("%I:%M%p") + ' to ' + slot.end_time.strftime("%I:%M%p") 
		shift_date = slot.start_date.strftime("%A, %b %d %Y")
		msg = '<span>The shift on <u>' + shift_date + '</u> from <u>' + shift_time + '</u> in the <u>' + slot.area.name + ' Area</u> '
		return_val = msg 

		if red == true
			return_val = '<span style="color: red;">' + msg 
		end

		return return_val	
	end
 
	def save_volunteers_to_area
		shifts = params[:shifts]
		remove_shifts = params[:removed_shifts].split(',').uniq
		volunteer = current_user.volunteer
		volunteer_event = VolunteerEvent.find(params[:volunteer_event_id])
		notice_array = Array.new
		remove = 'has been successfully removed.'
		no_remove = 'could not be removed because '
		add = 'has been successfully added.'
		no_add = 'could not be added becasue '
		es = '</span>'

		if shifts.blank? && remove_shifts.blank?
			send_to(:back, "No shifts selected or removed.")
			return
		end
		
		unless shifts.blank?
			remove_shifts = remove_shifts - (shifts & remove_shifts)	
		end

		unless remove_shifts.blank?
			remove_shifts.each do |remove_shift|
				current_shift = Shift.find(remove_shift)
				unless current_shift.blank?
					current_shift.volunteer_id = ''
					if current_shift.save
						notice_array.push(shift_notice(current_shift.slot, false) +  remove + es)
					else
						notice_array.push(shift_notice(current_shift.slot, true) +  no_remove + current_shift.errors.full_messages[0] + es)
					end
				end
			end
		end

		unless shifts.blank?
			shifts.each do |shift|
				current_shift =	Shift.find(shift)
				unless current_shift.volunteer_id == volunteer.id
					current_shift.volunteer_id = volunteer.id
					if current_shift.save
						notice_array.push(shift_notice(current_shift.slot, false) + add + es)
					else
   					notice_array.push(shift_notice(current_shift.slot, true) + no_add + current_shift.errors.full_messages[0] + es)
					end
				end
			end	
		end	

		
		if volunteer_event.required_shifts < shifts.length
			notice_array.push('<span style="color: red;>You have not signed up for enough shifts.</span>')
		elsif volunteer_event.required_shifts > shifts.length
			notice_array.push('<span style="color: blue;>You have signed up for too many shifts, you may want to remove some.</span>')
		end

		session[:notice_array] = notice_array
		send_to(:back, '')
	end

	def send_to(location, notice)
		respond_to do |format|
      format.html { redirect_to location, notice:  notice.to_s }
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
