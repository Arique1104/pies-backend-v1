class Api::V1::PiesEntriesController < ApplicationController

      before_action :set_user

      def index
        entries = @user.pies_entries.order(checked_in_on: :desc)
        render json: entries
      end

      def create
        entry = @user.pies_entries.new(pies_entry_params)
        if entry.save
          render json: entry, status: :created
        else
          render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        # Ideally use current_user if auth is set up
        @user = User.find(params[:user_id])
      end

      def pies_entry_params
        params.require(:pies_entry).permit(
          :event_id,
          :checked_in_on,
          :physical, :physical_description,
          :intellectual, :intellectual_description,
          :emotional, :emotional_description,
          :spiritual, :spiritual_description
        )
      end
end
