Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :shippings, only: [:show, :new, :create] do
    get 'search', on: :collection
  end
  resources :vehicles, only: [:index, :create, :new]
  resources :costs, only: [:create, :new]
  resources :deliv_terms, only: [:create, :new]

end
