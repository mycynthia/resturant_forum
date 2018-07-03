class Admin::CategoriesController < ApplicationController
  # 驗證請求進入後台的是否為已登入的 User
  before_action :authenticate_user!
  # 驗證該 User 身份是否為網站管理員
  before_action :authenticate_admin
end
