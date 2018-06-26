Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 透過路由設定，產生對外開放的網址入口
  # 前面加 /，就是將首頁指向 RestaurantsController 的 index action。
  root "restaurants#index"

end
