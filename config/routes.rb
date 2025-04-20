Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "/controller-alive", to: "api/v1/users#ping"

  namespace :api do
    namespace :v1 do
      # 🔐 Authenticated user actions
      resources :users, only: [ :create ], defaults: { format: :json } do
        resources :pies_entries, only: [ :index, :create ] do
          collection do
            get :latest
          end
        end
      end

      # 🔐 Authenticated routes for users (from token)
      resources :reflection_tips, only: [ :index ] do
        member do
          post :rate
          post :favorite
        end

        collection do
          get :favorites  # Secure favorites list, based on current_user, not URL param
        end
      end

      # 🔐 Auth
      post "/login", to: "sessions#create"
      get "/me", to: "sessions#show"

      # 🛠 Product owner controls for managing tips
      resources :reflection_tips, only: [ :create, :destroy, :update, :show ]

      resources :organizations, only: [ :create, :index, :show ]
      resources :memberships, only: [ :create ]
    end
  end
end
