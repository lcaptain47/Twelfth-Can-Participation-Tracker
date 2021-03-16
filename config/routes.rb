# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Comment

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  root 'events#index'
  resources :events
  resources :timeslots
  # resources :users
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  post '/claim/:id', to: 'timeslots#claim', as: 'claim'
end
