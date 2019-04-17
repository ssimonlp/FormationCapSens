# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/show', to: 'users#show', as: 'my_dashboard'
  post 'admin/projects/:id/success', to: 'admin/projects#promote_to_success', as: 'promote_to_success'
  post 'admin/projects/:id/faillure', to: 'admin/projects#promote_to_failure', as: 'promote_to_failure'
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
