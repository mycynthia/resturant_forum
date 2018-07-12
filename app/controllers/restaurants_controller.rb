class RestaurantsController < ApplicationController
  before_action :authenticate_user!
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
end
