Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :shippings, only: [:show, :new, :create] do
    get 'search', on: :collection
  end
  resources :vehicles, only: [:index, :create, :new]
  resources :costs, only: [:index, :create, :new]

end
