# frozen_string_literal: true

Rails.application.routes.draw do
  get 'projects/index', to: 'projects#index', as: 'projects'
  get 'projects/:id/show', to: 'projects#show', as: 'project'
  post 'projects/:id/show', to: 'contributions#create', as: 'new_contribution'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/show', to: 'users#show', as: 'my_dashboard'
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
