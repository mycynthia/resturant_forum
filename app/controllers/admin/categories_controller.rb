class Admin::CategoriesController < ApplicationController
  # 驗證請求進入後台的是否為已登入的 User
  before_action :authenticate_user!
  # 驗證該 User 身份是否為網站管理員
  before_action :authenticate_admin

  def index
    @categories = Category.all
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
