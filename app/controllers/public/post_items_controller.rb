class Public::PostItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  
  def new
    @post_item = PostItem.new
  end

  def create
    @post_item = PostItem.new(post_item_params)
    @post_item.customer_id = current_customer.id
    if @post_item.save
      redirect_to post_item_path(@post_item), notice: "You have created book successfully."
    else
      render "new"
    end
  end

  def index
    if params[:latest]
      @post_items = PostItem.latest.page(params[:page]).per(10)
    elsif params[:old]
      @post_items = PostItem.old.page(params[:page]).per(10)
    elsif params[:comment_count]
      @post_items = PostItem.order(comment_count: :desc).page(params[:page]).per(10)
    elsif params[:favorite_count]
      @post_items = PostItem.order(favorite_count: :desc).page(params[:page]).per(10)
    elsif params[:tag_id].present?
      @post_items = Tag.find(params[:tag_id]).post_items.page(params[:page]).per(10)
    else
      @post_items = PostItem.page(params[:page]).per(10)
    end
  end

  def show
    @post_comment = PostComment.new
    @post_item = PostItem.find(params[:id])
    unless ViewCount.find_by(customer_id: current_customer.id, post_item_id: @post_item.id)
      current_customer.view_counts.create(post_item_id: @post_item.id)
    end
  end

  def edit
    @post_item = PostItem.find(params[:id])
  end

  def update
    @post_item = PostItem.find(params[:id])
    if @post_item.update(post_item_params)
      redirect_to post_item_path(@post_item), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to post_items_path
  end

  def search
    @post_items = PostItem.search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_item_params
    params.require(:post_item).permit(:name, :image, :price, :explanation, :thoughts, :recommend_point, tag_ids: [])
  end
  
  def ensure_correct_customer
    @post_item = PostItem.find(params[:id])
    unless @post_item.customer == current_customer
    redirect_to post_items_path
    end
  end
end
