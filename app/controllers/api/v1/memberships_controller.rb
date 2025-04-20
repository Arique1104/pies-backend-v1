# class Api::V1::MembershipsController < ApplicationController
#   before_action :authorize_manager_or_owner!

#   def create
#     # step 1: fetch the target org
#     org = Organization.find_by(id: membership_params[:organization_id])
#     unless org
#       return render json: { error: "Organization not found" }, status: :not_found
#     end
#     # step 2: verify current_user belongs to that org and has Manager/owner role in it
#     unless current_user.memberships.exists?(organization_id: org.id, role: [ "manager", "owner" ])
#       return render json: { error: "You do not have permission to add members to this organization" }, status: :unauthorized
#     end
    
#     # step 3: proceed with create the membership for the specificed user
#     membership = Membership.new(membership_params)
#     if membership.save
#       render json: membership, status: :created
#     else
#       render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   private

#   def membership_params
#     params.require(:membership).permit(:user_id, :organization_id, :role)
#   end
# end
