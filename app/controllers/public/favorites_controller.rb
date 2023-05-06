class Public::FavoritesController < ApplicationController

  def create
    @post_item = PostItem.find(params[:post_item_id])
    favorite = current_customer.favorites.new(post_item_id: @post_item.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @post_item = PostItem.find(params[:post_item_id])
    favorite = current_customer.favorites.find_by(post_item_id: @post_item.id)
    favorite.destroy
    redirect_to request.referer
  end
end
