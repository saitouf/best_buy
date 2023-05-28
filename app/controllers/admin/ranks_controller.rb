class Admin::RanksController < ApplicationController
  before_action :authenticate_admin!

   # 投稿のいいね数、日・週・月別ランキング
  def rank
    if params[:favorite_daycount]
      @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).where(created_at: Time.current.all_day).order('count(post_item_id) desc').pluck(:post_item_id)).sort_by { |post| -post.favorites.count }
    elsif params[:favorite_weekcount]
      @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).where(created_at: Time.current.all_week).order('count(post_item_id) desc').pluck(:post_item_id)).sort_by { |post| -post.favorites.count }
    elsif params[:favorite_monthcount]
      @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).where(created_at: Time.current.all_month).order('count(post_item_id) desc').pluck(:post_item_id)).sort_by { |post| -post.favorites.count }
    else
      @post_favorite_ranks = PostItem.find(Favorite.group(:post_item_id).order('count(post_item_id) desc').pluck(:post_item_id)).sort_by { |post| -post.favorites.count }
    end
  end
end
