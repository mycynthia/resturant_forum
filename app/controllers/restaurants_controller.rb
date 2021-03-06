class RestaurantsController < ApplicationController
  # before_action :authenticate_user! 移至applicationcontroller
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end
  def feeds
    # 餐廳(評論)依新到舊排序，並取餐廳(評論)最新十筆資料
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end
  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    # @restaurant.count_favorites 加入counter_cache後刪除
    redirect_back(fallback_location: root_path)
  end
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorites = Favorite.where(restaurant: @restaurant)
    favorites.destroy_all
    # @restaurant.count_favorites 加入counter_cache後刪除
    redirect_back(fallback_location: root_path)
  end
  def like
    @restaurant = Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end
  def unlike
    @restaurant = Restaurant.find(params[:id])
    likes = Like.where(restaurant: @restaurant, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end
  #Get/restaurants/ranking
  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end
end
