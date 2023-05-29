class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @post_item = PostItem.find(params[:post_item_id])
    @post_comment=PostComment.find_by(id: params[:id], post_item_id: params[:post_item_id])
    @post_comment.destroy
    @post_comment = PostComment.new
  end
end
