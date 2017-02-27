Rails.application.routes.draw do
  #Topページへのルート
  root to:  'stasic_pages#home'
  
  #新規登録へのルート
  get 'signup', to: 'users#new'
  
  resources :users
  
end