Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :shippings, only: %i[show new create] do
    get 'search', on: :collection
    post 'select_modal', on: :member
  end
  resources :vehicles, only: %i[index create new edit update]
  resources :vehicle_types, only: %i[new create]
  resources :vehicle_categories, only: %i[new create]
  resources :costs, only: %i[create new]
  resources :deliv_terms, only: %i[create new]
  resources :orders, only: %i[index create new show edit update] do
    get 'search', on: :collection
    post 'select_modal', on: :member
  end
end
