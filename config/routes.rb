Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "/controller-alive", to: "api/v1/users#ping"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create], defaults: { format: :json } do
        resources :pies_entries, only: [:index, :create] do
          collection do
            get :latest
          end
        end
      end

      post "/login", to: "sessions#create"
      get "/me", to: "sessions#show"

      resources :organizations, only: [:create, :index, :show]
      resources :memberships, only: [:create]
      resources :reflection_tips, only: [:index, :create, :destroy]
    end
  end
end