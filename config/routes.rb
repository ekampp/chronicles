Chronicles::Application.routes.draw do
  namespace :admin do
    resources :projects, except: [ :show ]
  end

  get "auth/:provider/:callback", to: "sessions#create", as: :sign_in_callback
  get :sign_in, to: "sessions#sign_in", as: :sign_in
  get :sign_out, to: "sessions#sign_out", as: :sign_out

  get "/user/edit", to: "user#edit", as: :edit_user
  resources :user, only: [ :edit, :update ]

  resources :contact_attempts, only: [ :create ]

  root to: "home#index"
end
