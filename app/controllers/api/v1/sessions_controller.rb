class Api::V1::SessionsController < ApplicationController
     def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          render json: { user: user, token: token }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def show
        if current_user
          render json: { user: current_user }
        else
          render json: { error: "Not logged in" }, status: :unauthorized
        end
      end
end
