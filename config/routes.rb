# frozen_string_literal: true

Rails.application.routes.draw do
  post 'checkout/create' => 'checkout#create', as: 'checkout_create'

  get 'carts/:id', to: 'carts#show', as: 'cart'
  delete 'carts/:id', to: 'carts#destroy'

  post 'line_items/:id/add', to: 'line_items#add_quantity', as: 'line_item_add'
  post 'line_items/:id/reduce', to: 'line_items#reduce_quantity', as: 'line_item_reduce'
  post 'line_items', to: 'line_items#create'
  get 'line_items/:id', to: 'line_items#show', as: 'line_item'
  delete 'line_items/:id', to: 'line_items#destroy'

  resources :products do
    resources :comments
  end
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :coupons
  get 'order', to: 'orders#create', as: 'final_order'
  get 'orders', to: 'orders#index', as: 'orders'
  root 'products#index'
end
