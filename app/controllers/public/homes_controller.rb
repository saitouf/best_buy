class Public::HomesController < ApplicationController
  
  def top
    @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).order('count(post_item_id) desc').pluck(:post_item_id))
  end
  
  def about
  end
end
