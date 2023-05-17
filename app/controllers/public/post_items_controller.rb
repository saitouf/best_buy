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
    if params[:latest]
      @post_items = PostItem.latest
    elsif params[:old]
      @post_items = PostItem.old
    elsif params[:comment_count]
      @post_items = PostItem.comment_count
    elsif params[:tag_id].present?
      @post_items = Tag.find(params[:tag_id]).post_items
    else
      @post_items = PostItem.all
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
    @post_items = PostItem.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_item_params
    params.require(:post_item).permit(:name, :image, :price, :explanation, :thoughts, :recommend_point, tag_ids: [])
  end
end
