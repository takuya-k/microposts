Rails.application.routes.draw do
  #Topページへのルート
  root to: 'static_pages#home'
  
  #新規登録へのルート
  get 'signup', to: 'users#new'

  #ログイン・ログアウトのルート
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #フォロー一覧、フォロワー一覧のルート
  get    'show_following_user/:id', to: 'users#show_following_user', as: 'show_following_user'
  get    'show_follower_user/:id',  to: 'users#show_follower_user', as: 'show_follower_user'
  
  #お気に入り一覧
  get    'show_favorite/:id', to: 'users#show_favorite', as: 'show_favorite'
  
  #お気に入りの登録
  post   'favorite/:id', to: 'favorites#create', as: 'favorites'

  resources :users
  resources :microposts do
    member do
      get 'retweet'
     end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:destroy]
end