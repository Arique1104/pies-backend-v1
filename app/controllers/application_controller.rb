# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def decoded_token
    auth_header = request.headers["Authorization"]
    return unless auth_header

    token = auth_header.split(" ")[1]
    begin
      JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")[0]
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    return unless decoded_token
    @current_user ||= User.find_by(id: decoded_token["user_id"])
  end

  def authorize_user
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  def authorize_manager_or_owner!
    unless current_user&.role.in?(%w[manager owner])
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def authorize_owner!
    unless current_user&.super_user?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
