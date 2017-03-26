Rails.application.routes.draw do
  #root "pages#home"
	get 'pages/home'

  root "pages#index"
	get 'pages/index', to: 'pages#index'
end
