Rails.application.routes.draw do
  use_doorkeeper
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'accounts#index'

  resources :accounts, only: %i[index edit update]
end
