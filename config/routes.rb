Rails.application.routes.draw do
  root to: 'toppages#index'
  
  post '/', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'trial_login', to: 'sessions#trial_login'
  
  resources :users, except: [:index]
  resources :schedules, except: [:index]
  resources :works 
  resources :expenses 
end
