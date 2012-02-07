class LeadsController < ApplicationController

  before_filter :find_lead, :except => [:index, :new, :create]

  # GET /leads
  # GET /leads.json
  def index
    @leads = Lead.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leads }
    end
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    respond_to do |format|
      format.html { lead_path(@lead) }
      format.json { render json: @lead }
    end
  end

  # GET /leads/new
  # GET /leads/new.json
  def new
    @lead = Lead.new(:user => current_user)
    @contact = @lead.build_contact
    @address = @contact.build_address
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead }
    end
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(:user => current_user)
    @contact = @lead.build_contact
    @address = @contact.build_address
    @lead.attributes  = params[:lead]
    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
        format.json { render json: @lead, status: :created, location: @lead }
      else
        format.html { render action: "new" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leads/1
  # PUT /leads/1.json
  def update

    respond_to do |format|
      if @lead.update_attributes(params[:lead])
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    if @lead.destroy
      flash[:notice] = "Lead Destroyed"
    else
      flash[:error] = "Unable to destroy lead."
    end
    respond_to do |format|
      format.html { redirect_to leads_url }
      format.json { head :ok }
    end
  end

  private

  def find_lead
    @lead = Lead.find(params[:id])
  end

end
