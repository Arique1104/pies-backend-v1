class Api::V1::ReflectionTipsController < ApplicationController
      def index
        # This function should be scoped to match the user's reflection 
          tips = ReflectionTip.all.order(:category, :keyword)
          render json: tips
      end

      # def create
      #     tip = ReflectionTip.new(tip_params)
      #     if tip.save
      #       render json: tip, status: :created
      #     else
      #       render json: { errors: tip.errors.full_messages }, status: :unprocessable_entity
      #     end
      # end

      # def destroy
      #   tip = ReflectionTip.find(params[:id])
      #   tip.destroy
      #   head :no_content
      # end

      def rate
        tip = ReflectionTip.find(params[:id])
        rating = TipRating.find_or_initialize_by(user: current_user, reflection_tip: tip)
        rating.helpful = params[:helpful]
        rating.save!
        render json: { success: true }
      end

      def favorite
        tip = ReflectionTip.find(params[:id])
        FavoriteTip.find_or_create_by(user: current_user, reflection_tip: tip)

        head :ok
      end

      def favorites
        tips = current_user.favorited_reflection_tips
        render json: tips
      end
      private

      def tip_params
        params.require(:reflection_tip).permit(:keyword, :category, :tip)
      end
end
