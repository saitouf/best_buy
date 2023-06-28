class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post_item = PostItem.find(params[:post_item_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_item_id = @post_item.id
    comment.save
    @post_comment = PostComment.new
  end

  def destroy
    @post_item = PostItem.find(params[:post_item_id])
    @post_comment=PostComment.find_by(id: params[:id], post_item_id: params[:post_item_id])
    @post_comment.destroy
    @post_comment = PostComment.new
  end
  
  def new
    @post_item = PostItem.find(params[:post_item_id])
    @post_comment = @post_item.post_comments.new(parent_id: params[:parent_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :parent_id)
  end
end
