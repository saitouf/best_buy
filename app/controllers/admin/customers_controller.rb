class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:favorites]

  def index
    @customers = Customer.page(params[:page]).per(9)
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
      redirect_to admin_customers_path, notice: "ユーザー情報を編集しました。"
    else
      render "edit"
    end
  end
  
  def favorites
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_item_id)
    @favorite_posts = PostItem.where(id: favorites)
  end
  
  def search
    @customers = Customer.search(params[:customer_keyword]).page(params[:page]).per(10)
    @customer_keyword = params[:customer_keyword]
    render "index"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
