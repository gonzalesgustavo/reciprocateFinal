Rails.application.routes.draw do
  # get 'users/show'

  root 'posts#index'

  devise_for :users,
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up:  'registration'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users/:id', to: 'users#show'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show,  :create, :destroy] do
  	resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
    resources :bookmarks, only: [:create, :destroy], shallow: true
  end
end
 