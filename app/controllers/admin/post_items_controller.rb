class Admin::PostItemsController < ApplicationController

  def index
    @post_items = PostItem.all
  end

  def show
    @post_comment = PostComment.new
    @post_item = PostItem.find(params[:id])
  end

  def edit
    @post_item = PostItem.find(params[:id])
  end

  def update
    @post_item = PostItem.find(params[:id])
    if @post_item.update(post_item_params)
      redirect_to admin_post_item_path(@post_item), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to admin_post_items_path
  end

  private

  def post_item_params
    params.require(:post_item).permit(:name, :image, :price, :explanation, :thoughts, :recommend_point, tag_ids: [])
  end
end
