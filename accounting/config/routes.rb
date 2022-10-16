Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "billing_cycles#current"

  resources :billing_cycles, only: [:show] do
    collection do
      get :current
    end

    resources :accounts, only: [:show]
  end
end
