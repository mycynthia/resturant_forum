class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action需放在protect_form方法之下
  before_action :authenticate_user!
  # 客製化devise gem 加username
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # 以下移至Admin::BaseController
  # private
  #   def authenticate_admin
  #     unless current_user.admin?
  #       flash[:alert] = "Not allow"
  #       redirect_to root_path
  #     end
  #   end
end
