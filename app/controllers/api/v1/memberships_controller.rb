class Api::V1::MembershipsController < ApplicationController
  before_action :authorize_manager_or_owner!, only [:create]

  def create
    membership = Membership.new(membership_params)
    if membership.save
      render json: membership, status: :created
    else
      render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :organization_id, :role)
  end
end
