class Public::PostItemsController < ApplicationController
  def new
    @post_item = PostItem.new
  end

  def create
    @post_item = PostItem.new(post_item_params)
    @post_item.customer_id = current_customer.id
    @post_item.save
    redirect_to post_item_path(@post_item), notice: "You have created book successfully."
  end

  def index
    @post_items = PostItem.all
  end

  def show
    @post_item = PostItem.find(params[:id])
    @post_comment = PostComment.new
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

  private

  def post_item_params
    params.require(:post_item).permit(:name, :image, :category, :price, :explanation, :thoughts, :recommend_point)
  end
end
