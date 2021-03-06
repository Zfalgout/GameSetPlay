Rails.application.routes.draw do
  #get 'password_resets/new'

  #get 'password_resets/edit'

  #get 'sessions/new'

  #get 'users/new'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  get 'new_match' => 'matches#new'

  get 'open' => 'matches#open'

  get 'challenges' => 'matches#challenges'


  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only:  [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :matches do
    member do
      get :join
    end
  end
end
