class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated admin successfully."
    else
      render "edit"
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end
end
