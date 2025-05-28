# app/controllers/api/v1/org_dashboards_controller.rb
class Api::V1::OrgDashboardsController < ApplicationController
  include OrgTokenAuth

  def show
    if current_user.super_user? && token_from_header.blank?
      # If super_user with no org_token, just return everything (or scoped subset)
      orgs = Organization.all # limit for performance, optional
      render json: {
        super_user: true,
        accessible_orgs: orgs.map do |org|
          {
            id: org.id,
            name: org.name,
            description: org.description,
            member_count: org.memberships.count
          }
        end
      } and return
    end

    # Fallback to org_token logic
    decoded = JsonWebToken.decode(token_from_header)
    membership = Membership.find_by(id: decoded["membership_id"])

    return unauthorized unless membership&.user_id == current_user.id

    org = membership.organization
    members = org.memberships.includes(:user)

    render json: {
      organization: org.as_json(only: [ :id, :name, :description ]),
      members: members.map { |m| m.as_json(include: :user, only: [ :id, :role ]) }
    }
  end
end
