Rails.application.routes.draw do
  #get 'chefs/index'

  #get 'chefs/show'

  #get 'chefs/new'

  #get 'chefs/edit'

  #get 'chefs/delete'
  resources :chefs do # default
    member do
      get :delete #should be added ,not part of default resources
    end
  end

  resources :recipes do # default
    member do
      get :delete #should be added ,not part of default resources
    end
  end

  #root "pages#home"
	get 'pages/home'

  root "pages#home"
	#get 'recipes/index', to: 'recipes#index'
end
