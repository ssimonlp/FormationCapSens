# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show', to: 'users#show', as: 'my_dashboard'
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
