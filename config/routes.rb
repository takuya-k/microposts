Rails.application.routes.draw do
  #Topページへのルート
  root to: 'static_pages#home'
  
  #新規登録へのルート
  get 'signup', to: 'users#new'

  #ログイン・ログアウトのルート
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end