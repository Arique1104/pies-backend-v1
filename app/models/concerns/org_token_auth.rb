module OrgTokenAuth
    extend ActiveSupport::Concern

    included do
        before_action :require_org_token!
        attr_reader :current_user, :current_org, :current_membership
    end

    def require_org_token!
        token = request.headers["Authorization"]&.split(" ")&.last
        payload = JsonWebToken.decoded(token)

        if payload.blank? || payload["org_id"].blank?
            render json: { error: "Missing or invalid organization token" }, status: :unauthorized and return
        end

        @current_user = User.find_by(id: payload["user_id"])
        @current_org = Organization.find_by(id: payload["org_id"])
        @current_membership = Membership.find_by(id: payload["membership_id"], user_id: payload["user_id"])

        unless @current_user && @current_org && @current_membership
            render json: { error: "Unathoriized access to organization" }, status: :unathorized and return
        end
    end
end
