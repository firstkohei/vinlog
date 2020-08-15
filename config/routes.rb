Rails.application.routes.draw do
 
  resources :uploads
 root to: 'toppages#index'
 
 get 'about', to: 'toppages#about'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
 
 resources :users do
  member do
   get :likes
  end
 end
 
 resources :wines
 resources :favorites, only: [:create, :destroy]
 resources :password_resets,     only: [:new, :create, :edit, :update]
end
