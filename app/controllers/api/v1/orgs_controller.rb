class Api::V1::OrgsController < ApplicationController
    before_action :authorize_owner!
# accesses organization-table and creates new organizations
# must have a coded id for security
    def index
        render json: { message: "Owner access to orgs confirmed." }
    end
end