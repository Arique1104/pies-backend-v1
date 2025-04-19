class Api::V1::ReflectionTipsController < ApplicationController
    def index
        tips = ReflectionTip.all.order(:category, :keyword)
        render json: tips
      end

      def create
        tip = ReflectionTip.new(tip_params)
        if tip.save
          render json: tip, status: :created
        else
          render json: { errors: tip.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        tip = ReflectionTip.find(params[:id])
        tip.destroy
        head :no_content
      end

      private

      def tip_params
        params.require(:reflection_tip).permit(:keyword, :category, :tip)
      end
    end
end
