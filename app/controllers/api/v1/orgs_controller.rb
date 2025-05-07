class API::V1::OrgsController < ApplicationController
    before_action :authorize_owner!

    def index
        render json: { message: "Owner access to orgs confirmed." }
    end
end