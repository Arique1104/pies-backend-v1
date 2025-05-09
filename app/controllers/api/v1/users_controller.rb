class Api::V1::UsersController < ApplicationController
    def create
    user = User.new(user_params)
    user.super_user = true if User.count.zero?

    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
