Rails.application.routes.draw do
  use_doorkeeper
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'
end
