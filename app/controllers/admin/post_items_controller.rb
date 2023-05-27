class Admin::PostItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:latest]
      @post_items = PostItem.latest.page(params[:page]).per(10)
    elsif params[:old]
      @post_items = PostItem.old.page(params[:page]).per(10)
    elsif params[:comment_count]
      post_item_id = PostComment.group(:post_item_id).order('count(post_item_id) desc').pluck(:post_item_id)
      @post_items = PostItem.where(id: post_item_id).order_as_specified(id: post_item_id).page(params[:page]).per(10)
    elsif params[:favorite_count]
      post_item_id = Favorite.group(:post_item_id).order('count(post_item_id) desc').pluck(:post_item_id)
      @post_items = PostItem.where(id: post_item_id).order_as_specified(id: post_item_id).page(params[:page]).per(10)
    elsif params[:tag_id].present?
      @post_items = Tag.find(params[:tag_id]).post_items.page(params[:page]).per(10)
    else
      to = Time.current.at_end_of_day
      from = (to - 30.days).at_beginning_of_day
      @post_items = PostItem.where(created_at: from..to).order(created_at: :desc).page(params[:page]).per(10)
    end
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
      redirect_to admin_post_item_path(@post_item), notice: "投稿編集が完了しました."
    else
      render "edit"
    end
  end

  def destroy
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to admin_post_items_path
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
end
