Rails.application.routes.draw do
  
  get 'sessions/new'
  get 'users/new'
	root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'error_404' => 'static_pages#not_found'
  get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :categories, :path => 'c' # e.g. localhost:3000/c/shirts
  resources :comments
  resources :posts, only: [:new, :show, :create, :destroy] do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
    resources :comments
  end
  
  get "*any", via: :all, to: "static_pages#not_found" # path error handling
end
