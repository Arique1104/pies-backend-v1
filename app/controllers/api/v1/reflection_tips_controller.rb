class Api::V1::ReflectionTipsController < ApplicationController
  before_action :authorize_user
  before_action :authorize_owner!, only: [ :create, :update, :destroy ]

      def index
          # This function should be scoped to match the user's reflection
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

    def update
      tip = ReflectionTip.find(params[:id])

      if tip.update(tip_params)
        render json: tip, status: :ok
      else
        render json: { errors: tip.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      tip = ReflectionTip.find(params[:id])

      ActiveRecord::Base.transaction do
        DismissedKeyword.find_or_create_by!(word: tip.keyword, category: tip.category, example: tip.tip)
        tip.destroy!
      end

      head :no_content
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

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
