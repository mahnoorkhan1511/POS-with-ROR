Rails.application.routes.draw do
  devise_for :users, controllers: {
    invitations: "users/invites"
  }
  namespace :admin do
    # get "dashboard", to: "dashboard#show", as: :dashboard
    resources :dashboard, only: [ :index ]
    resources :employees, only: [ :index ] do
      patch :resend_invitation
    end
  end
  # devise_for :users do
  #   get "/users/sign_out" => "devise/sessions#destroy"
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :home, only: [ :index ]
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "dashboard", to: "home#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
