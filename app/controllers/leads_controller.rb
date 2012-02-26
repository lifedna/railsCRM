class LeadsController < ApplicationController

  before_filter :find_lead, :except => [:index, :new, :create]

  def index
    @leads = Lead.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leads }
    end
  end

  def show
    respond_to do |format|
      format.html { lead_path(@lead) }
      format.json { render json: @lead }
    end
  end

  def new
    @lead = Lead.new(:user => current_user)
    @contact = @lead.build_contact
    @address = @contact.build_address
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead }
    end
  end

  def edit
  end

  def create
    @lead = Lead.create(params[:lead])
    #@lead.contact.phones.build(params[:phones])
    #@lead.contact.build_address(params[:address])
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
