# frozen_string_literal: true

Rails.application.routes.draw do
  resources :checkout, only: %i[create]
  resources :carts, only: %i[show destroy]

  resources :line_items do
    member do
      post 'add_quantity'
      post 'reduce_quantity'
    end
  end

  resources :products do
    resources :comments
  end

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only: %i[index] do
    collection do
      get 'success_payment'
    end
  end
  root 'products#index'
end
