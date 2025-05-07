class Api::V1::MoneysController < ApplicationController
    before_action :authorize_owner!

    def index
        render json: { message: "Owner access to money confirmed." }
    end
end
