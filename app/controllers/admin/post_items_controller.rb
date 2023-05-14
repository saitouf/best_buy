class Admin::PostItemsController < ApplicationController
  
  def index
    @post_items = PostItem.all
  end
  
  def show
    @post_comment = PostComment.new
    @post_item = PostItem.find(params[:id])
  end
end
