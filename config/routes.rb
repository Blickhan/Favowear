Rails.application.routes.draw do
  
  get 'sessions/new'
  get 'users/new'
	root 'static_pages#home'
  get "/fetch_posts" => 'static_pages#filter_posts', as: 'fetch_posts'
  get "/fetch_category_posts" => 'categories#filter_posts', as: 'fetch_category_posts'
  get "/fetch_categories" => 'categories#order_categories', as: 'fetch_categories'
  get "/c/all" => 'categories#all' #pseudocategory
  get 'search' => 'static_pages#search'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'error_404' => 'static_pages#not_found'
  get 'sitemap.xml', :to => 'static_pages#sitemap', :defaults => {:format => 'xml'}
  get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :followings, only: [:create, :destroy]
  resources :users do
    member do
      get :categories
    end
  end
  resources :categories, :path => 'c' # e.g. localhost:3000/c/shirts
  resources :comments do
    member do
      put "upvote", to: "comments#upvote"
      put "downvote", to: "comments#downvote"
    end
  end
  resources :posts, only: [:new, :show, :create, :destroy] do
    member do
      put "upvote", to: "posts#upvote"
      put "downvote", to: "posts#downvote"
    end
    resources :comments
  end
  
  get "*any", via: :all, to: "static_pages#not_found" # path error handling
end
