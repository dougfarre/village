class AvailsController < ApplicationController
  # GET /avails
  # GET /avails.json
  def index
    @avails = Avail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @avails }
    end
  end

  # GET /avails/1
  # GET /avails/1.json
  def show
    @avail = Avail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @avail }
    end
  end

  # GET /avails/new
  # GET /avails/new.json
  def new
    @avail = Avail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @avail }
    end
  end

  # GET /avails/1/edit
  def edit
    @avail = Avail.find(params[:id])
  end

  # POST /avails
  # POST /avails.json
  def create
    @avail = Avail.new(params[:avail])

    respond_to do |format|
      if @avail.save
        format.html { redirect_to @avail, notice: 'Avail was successfully created.' }
        format.json { render json: @avail, status: :created, location: @avail }
      else
        format.html { render action: "new" }
        format.json { render json: @avail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /avails/1
  # PUT /avails/1.json
  def update
    @avail = Avail.find(params[:id])

    respond_to do |format|
      if @avail.update_attributes(params[:avail])
        format.html { redirect_to @avail, notice: 'Avail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @avail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avails/1
  # DELETE /avails/1.json
  def destroy
    @avail = Avail.find(params[:id])
    @avail.destroy

    respond_to do |format|
      format.html { redirect_to avails_url }
      format.json { head :no_content }
    end
  end
end
