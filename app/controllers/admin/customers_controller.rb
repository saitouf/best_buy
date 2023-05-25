class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @post_comment = PostComment.new
    @post_items = @customer.post_items.page(params[:page]).per(9)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "You have updated admin successfully."
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end
end
