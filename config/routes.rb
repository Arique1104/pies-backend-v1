Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # growth summary
      get "growth_summary", to: "growth#summary"

      # 🔐 Auth
      post "/login", to: "sessions#create"
      get "/me", to: "sessions#show"

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


      # Org Owner Dashboard Controllers
      resources :memberships, only: [ :create ]

      # 🛠 Product Owner Dashboard Controllers
      # resources :reflection_tips, only: [ :create, :destroy, :update ]
      resources :dismissed_keywords, only: [ :index, :destroy, :create ]
      resources :unmatched_keywords, only: [ :index ]

      resources :orgs, only: [ :index ]


      resources :insights, only: [ :index ]

      resources :moneys, only: [ :index ]
    end
  end
end
