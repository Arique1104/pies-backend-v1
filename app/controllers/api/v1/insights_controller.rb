class Api::V1::InsightsController < ApplicationController
    before_action :authorize_owner!

    def index
        render json: { message: "Owner access to insights confirmed." }
    end
end