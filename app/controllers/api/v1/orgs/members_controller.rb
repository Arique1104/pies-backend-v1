class Api::V1::Orgs::MembersController < ApplicationController
  before_action :set_org_context!

  # POST /orgs/members
def create
  members_params.each do |member_param|
    user = User.find_or_initialize_by(email: member_param[:email])

    if user.new_record?
      user.password = SecureRandom.hex(16)  # Temporary password
      user.save!

      # Send invitation email
      UserMailer.org_invite(user, @org).deliver_later
    end

    Membership.find_or_create_by!(
      user: user,
      organization: @org
    ) do |membership|
      membership.role = member_param[:role]
    end
  end
    render json: { message: "Members added successfully" }, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH /orgs/members
  def update
    members_params.each do |member_param|
      membership = Membership.find_by(user_id: member_param[:user_id], organization_id: @org.id)
      next unless membership

      membership.update!(role: member_param[:role])
    end

    render json: { message: "Roles updated successfully" }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_org_context!
    if current_user.super_user?
      # Allow superusers to specify the org_id manually
      @org = Organization.find_by(id: params[:organization_id])
      render json: { error: "Org not found" }, status: :not_found unless @org
    else
      decoded = JsonWebToken.decode(token_from_header)
      membership = Membership.find_by(id: decoded["membership_id"], user_id: current_user.id)

      unless membership && decoded["role"] == "owner"
        render json: { error: "Unauthorized" }, status: :unauthorized and return
      end

      @org = membership.organization
    end
  end

  def members_params
    params.require(:members).map { |p| p.permit(:email, :role, :user_id) }
  end

  def token_from_header
    request.headers['Authorization']&.split(' ')&.last
  end
end