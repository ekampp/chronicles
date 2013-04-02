Chronicles::Application.routes.draw do
  get :sign_in, to: "sessions#new"
  get :sign_out, to: "sessions#destroy"
  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  resources :characters

  resources :users, only: [ :edit, :update ]

  root to: "application#index"
end
