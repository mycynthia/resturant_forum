class Admin::RestaurantsController < Admin::BaseController
  # before_action :authenticate_user! 移至applicationcontroller
  # before_action :authenticate_admin Admin::BaseController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end
  # new
  def new
    @restaurant = Restaurant.new
  end
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end
  # show
  def show
    
  end
  
  def edit
    
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully update"
      redirect_to admin_restaurants_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end
    def restaurant_params 
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image)
    end
  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
  end

  def set_restaurant
     @restaurant = Restaurant.find(params[:id])
  end
end
