class Public::CustomersController < ApplicationController
  # before_action :set_customerr, only: [:likes]

  def show
    @customer = Customer.find(params[:id])
    @post_comment = PostComment.new
    @post_items = @customer.post_items
  end

  def index
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
    @customer = current_customer
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_item_id)
    @favorites_posts = PostItem.find(favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  # def set_customer
  #   @customer = Customer.find(params[:id])
  # end
end
