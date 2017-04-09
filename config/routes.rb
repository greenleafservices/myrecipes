Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  get '/signup', to: 'chefs#new'
  get '/login', to:'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'chat', to: 'chatrooms#show' #chatrooms controller, show action



  mount ActionCable.server => '/cable'

  resources :chefs, except: [:new] #we want the new route to go to /signup
  #   member do
  #     get :delete #should be added ,not part of default resources
  #   end
  # end
  resources :recipes do # default
    member do
      get :delete #should be added ,not part of default resources
    end
    resources :comments, only: [:create] #a nested route for recipe comments
  end

  resources :ingredients do
    member do
      get :delete
    end
  end

  resources :comments do
    member do
      get :delete
    end
  end

  resources :messages, only: [:create]


end
