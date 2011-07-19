class ProspectsController < ApplicationController

  before_filter :load_prospect, :except => [:index, :new, :create]

  def index
    @prospects = Prospect.all
  end

  def new
    @prospect = Prospect.new
  end

  def create
    @prospect = Prospect.new(params[:prospect])
    if @prospect.save
      flash[:notice] = "Prospect is created successfully."
      redirect_to prospects_path
    else
      flash[:error] = "Error while creating Prospect."
      render :new
    end
  end

  def edit
  end

  def update
    if @prospect.update_attributes(params[:prospect])
      flash[:notice] = "Successfully updated #{@prospect.full_name}"
      redirect_to prospects_path
    else
      flash[:error] = "Error while updating prospect."
      render :edit
    end
  end

  def show
  end

  def destroy    
    if @prospect.destroy
      flash[:notice] = "Successfully deleted prospect."
      redirect_to prospects_path
    end
  end

  private
  
  def load_prospect
    @prospect = Prospect.find(params[:id])
  end
  
end