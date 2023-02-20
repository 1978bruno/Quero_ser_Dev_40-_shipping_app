Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :shippings, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    post 'select_modal', on: :member
  end
  resources :vehicles, only: [:index, :create, :new, :edit, :update]
  resources :vehicle_types, only: [:new, :create]
  resources :vehicle_categories, only: [:new, :create]
  resources :costs, only: [:create, :new]
  resources :deliv_terms, only: [:create, :new]
  resources :orders, only: [:index, :create, :new, :show, :edit, :update] do
    get 'search', on: :collection
    post 'select_modal', on: :member
  end
end
