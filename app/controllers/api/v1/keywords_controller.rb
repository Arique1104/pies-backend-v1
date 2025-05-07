class Api::V1::KeywordsController < ApplicationController
    before_action :authorize_owner!

    def index
        #  access all unmatched keywords
        render json: { message: "Owner access to keywords confirmed." }
    end

  # def dismiss_keyword
  # end

  # def create_reflection_tip
  # be mindful on what I'm getting out of tip_params here.
  #     tip = ReflectionTip.new(tip_params)
  #     if tip.save
  #       render json: tip, status: :created
  #     else
  #       render json: { errors: tip.errors.full_messages }, status: :unprocessable_entity
  #     end
  # end

  # def destroy_reflection_tip
  #   tip = ReflectionTip.find(params[:id])
  #   tip.destroy
  #   head :no_content
  # end
end
