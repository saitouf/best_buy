class Public::FavoritesController < ApplicationController

  def create
    @post_item = PostItem.find(params[:post_item_id])
    favorite = current_customer.favorites.new(post_item_id: @post_item.id)
    favorite.save
  end

  def destroy
    @post_item = PostItem.find(params[:post_item_id])
    favorite = current_customer.favorites.find_by(post_item_id: @post_item.id)
    favorite.destroy
  end
end
