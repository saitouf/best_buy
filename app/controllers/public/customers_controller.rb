class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  before_action :set_customer, only: [:favorites]
  before_action :ensure_normal_customer, only: %i[update withdrawal]


  def show
    @customer = Customer.find(params[:id])
    @post_items = @customer.post_items.page(params[:page]).per(9)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "ユーザー情報を更新しました。"
    else
      render "edit"
    end
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end

  def favorites
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_item_id)
    @post_items = PostItem.where(id: favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to post_items_path
    end
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  # ゲストログイン情報、編集・削除無効
  def ensure_normal_customer
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, notice: 'ゲストユーザーの更新・退会はできません。'
    end
  end
end
