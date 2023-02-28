Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :shippings, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    post 'select_modal', on: :member
    post 'active', on: :member
    post 'disable', on: :member
  end
  resources :vehicles, only: [:index, :create, :new, :edit, :update] do
    post 'active', on: :member
    post 'disable', on: :member
  end
  resources :vehicle_types, only: [:new, :create]
  resources :vehicle_categories, only: [:new, :create]
  resources :costs, only: [:create, :new]
  resources :deliv_terms, only: [:create, :new]
  resources :process_orders, only: [:index, :show, :edit, :create]
  resources :orders, only: [:index, :create, :new, :show, :edit, :update] do
    get 'search', on: :collection
    get 'select_modal', on: :member
    post 'canceled', on: :member
    get 'delivered', on: :member
    get 'delivering', on: :collection
  end
end
