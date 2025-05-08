Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # 🔐 Authenticated user actions
      resources :users, only: [ :create ], defaults: { format: :json }

      resources :pies_entries, only: [ :index, :create ] do
        collection do
          get :latest
        end
      end

      resources :reflection_tips, only: [ :index ] do
        member do
          post :rate
          post :favorite
        end

        collection do
          get :favorites
        end
      end

      # 🔐 Auth
      post "/login", to: "sessions#create"
      get "/me", to: "sessions#show"

      # 🛠 Product owner controls for managing tips
      resources :reflection_tips, only: [ :index, :create, :destroy, :update ]
      resources :dismissed_keywords, only: [:index, :destroy, :create]
      resources :orgs, only: [ :index ]
      resources :memberships, only: [ :create ]

      resources :unmatched_keywords, only: [ :index ]
      resources :insights, only: [ :index ]
      resources :moneys, only: [ :index ]
    end
  end
end
