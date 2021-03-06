class Admin::CategoriesController < Admin::BaseController
  # 驗證請求進入後台的是否為已登入的 User
  # before_action :authenticate_user! 移至applicationcontroller
  # 驗證該 User 身份是否為網站管理員
  # before_action :authenticate_admin 移至 Admin::BaseController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
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

  def update
      if @category.update(category_params)
        redirect_to admin_categories_path
        flash[:notice] = "category was successfully update"
      else
        @categories = Category.all
        render :index
      end
  end

  def destroy
    @category.destroy
      # 若要刪除category時，分類下有餐聽跟無餐廳顯示的文字有所不同
      if @category.destroy
        flash[:notice] = " category was successfully deleted "
      else
        flash[:alert] = @category.errors.full_messages.to_sentence
      end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
