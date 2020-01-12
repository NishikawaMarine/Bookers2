Rails.application.routes.draw do

	root 'homes#top'
	devise_for :users
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :relationships
	resources :books do
		resources :favorites, only: [:create, :destroy]
		resources :book_comments
	end
	get '/home/about',to: 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
