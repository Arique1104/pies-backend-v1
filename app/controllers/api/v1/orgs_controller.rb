class Api::V1::OrgsController < ApplicationController
    before_action :authorize_owner!

    def index
        query = params[:q]

        orgs = if current_user.super_user?
        Organization.all
        else
        current_user.organizations
        end

        orgs = orgs.where("name ILIKE ?", "%#{query}%") if query.present?

        render json: orgs, status: :ok
    end

    def switch
        org_id = request.headers["X-Org_ID"]
        unless org_id
            render json: { error: "Missing organization ID" }, status: :back_request and return
        end

        membership = current_user.memberships.find_by(organization_id: org_id)

        unless membership
            render json: { error: "Unathorirized access to organization" }, status: :unathorized and return
        end

        token = JsonWebToken.encode({
            user_id: current_user.id,
            org_id: membership.organization.id,
            membership_id: membership.id,
            role: membership.role
        })

        render json: { token: token }, status: :ok
    end

    def dashboard
        decoded = JsonWebToken.decode(token_from_header)
        membership = Membership.find(decoded["membership_id"])
        return unathortized unless membership.user_id == current_user.id

        org = membership.organization
        members = org.memberships.includes(:user)
        events = org.events
        render json: { org: org, members: members, events: events }
    end

def show
  org_id = params[:org_id] || request.headers["X-Org-ID"]
  org = Organization.find_by(id: org_id)

  if org.nil?
    render json: { error: "Org not found" }, status: :not_found
  else
    render json: org.as_json(
      only: [ :id, :name, :description ],
      include: {
        memberships: {
          only: [ :id, :role ],
          include: {
            user: {
              only: [ :id, :name, :email ]
            }
          }
        },
        events: {
          only: [ :id, :title, :date, :location ]
        }
      }
    ), status: :ok
  end
end

private

# Safely parse request body for org_id (in case of application/json POST)
def safe_parse_json_request_body
  JSON.parse(request.body.read).with_indifferent_access
rescue JSON::ParserError, EOFError
  {}
end
end
