Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 前台入口一般使用者，透過路由設定，產生對外開放的網址入口
  # 前面加 /，就是將首頁指向 RestaurantsController 的 index action。
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    # 瀏覽所有餐廳最新動態
    collection do
      get :feeds
      # 十大人氣餐廳
      get :ranking
    end

    
    member do
      # 瀏覽個別餐廳的Dashboard
      get :dashboard
      # 收藏跟反收藏餐廳，因不需樣板故用post
      post :favorite
      post :unfavorite
      # 喜歡跟取消喜歡的餐廳
      post :like
      post :unlike
    end
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :categories ,only: :show
  resources :followships, only: [:create, :destroy]
  root "restaurants#index"


  # 後台入口管理者是採用namespace來區隔建立admin名稱可以任意更改
  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end

