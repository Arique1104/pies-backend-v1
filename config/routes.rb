Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "org_dashboards/show"
      # growth summary
      get "growth_summary", to: "growth#summary"

      # 🔐 Auth
      post "/login", to: "sessions#create"
      get "/me", to: "sessions#show"

      get "/set_password", to: "users#edit_password"
      patch "/set_password", to: "users#update_password"

      # 🔐 Authenticated User PIES Checkin Dashboard
      resources :users, only: [ :create ], defaults: { format: :json }
      resources :pies_entries, only: [ :index, :create ] do
        collection do
          get :latest
        end
      end
      resources :reflection_tips, only: [ :index, :create, :destroy, :update ] do
        member do
          post :rate
          post :favorite
        end

        collection do
          get :favorites
        end
      end

      # User initiated sign up
      resources :memberships, only: [ :create ]

      # Org Owner Dashboard Controllers

      # 🛠 Product Owner Dashboard Controllers
      # resources :reflection_tips, only: [ :create, :destroy, :update ]
      resources :dismissed_keywords, only: [ :index, :destroy, :create ]
      resources :unmatched_keywords, only: [ :index ]

      post "/orgs/show", to: "orgs#show"
      post "my_orgs/switch", to: "orgs#switch"

      resources :orgs, only: [ :index, :update ]

      namespace :orgs do
        resources :members, only: [ :create, :update ]
      end

      resources :insights, only: [ :index ]

      resources :moneys, only: [ :index ]
    end
  end
end
