class Public::RanksController < ApplicationController

  def rank
    # 投稿のいいね数ランキング
    @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).order('count(post_item_id) desc').pluck(:post_item_id))
  end
end
