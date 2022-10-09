Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tasks#index"

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  resources :accounts, only: :index
  resources :tasks, only: %i[index show new create] do
    member do
      post :complete
    end
    collection do
      post :shuffle
    end
  end
end
