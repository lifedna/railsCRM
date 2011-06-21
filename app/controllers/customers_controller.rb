class CustomersController < ApplicationController

  before_filter :load_customer, :except => [:index, :new, :create]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = "Customer is created successfully."
      redirect_to customers_path
    else
      flash[:error] = "Error while creating Customer."
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated #{@customer.full_name}"
      redirect_to customers_path
    else
      flash[:error] = "Error while updating customer."
      render :edit
    end
  end

  def show
  end

  def destroy    
    if @customer.destroy
      flash[:notice] = "Successfully deleted customer."
      redirect_to customers_path
    else
      flash[:error] = "Error while deleting customer."
      render :index
    end
  end

  private
  
  def load_customer
    @customer = Customer.find(params[:id])
  end
  
end