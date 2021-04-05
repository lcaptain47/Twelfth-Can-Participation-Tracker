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
  resources :users
  # resources :users
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  post '/users/wipe_all', to: 'users#wipe_all', as: 'wipe_all'
  post '/claim/:id', to: 'timeslots#claim', as: 'claim'
  post '/unclaim/:id', to: 'timeslots#unclaim', as: 'unclaim'

  post '/unapprove/:id', to: 'timeslots#unapprove', as: 'unapprove' 
  post '/approve/:id', to: 'timeslots#approve', as: 'approve'

  post '/users/promote/:id', to: 'users#promote', as: 'promote'
  post '/users/demote/:id', to: 'users#demote', as: 'demote'


  get '/search', to: 'users#search_page', as: 'search_page'
  post '/search', to: 'users#search', as: 'search' 


end


