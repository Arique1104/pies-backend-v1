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

  def edit_password
    decoded = JsonWebToken.decode(params[:token])
    @user = User.find(decoded[:user_id])
  rescue
    redirect_to root_path, alert: "Invalid or expired token"
  end

  def update_password
    user = User.find(params[:user_id])
    if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      redirect_to root_path, notice: "Password set! You can now log in."
    else
      render :edit_password
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
