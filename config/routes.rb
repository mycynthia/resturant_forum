Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 前台入口一般使用者，透過路由設定，產生對外開放的網址入口
  # 前面加 /，就是將首頁指向 RestaurantsController 的 index action。
  root "restaurants#index"

  # 後台入口管理者是採用namespace來區隔建立admin名稱可以任意更改
  namespace :admin do
    root "restaurants#index"
  end

end
