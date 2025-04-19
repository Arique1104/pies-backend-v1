class Api::V1::EventHostsController < ApplicationController
     def create
        event_host = EventHost.new(event_host_params)
        if event_host.save
          render json: event_host, status: :created
        else
          render json: { errors: event_host.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        event_host = EventHost.find_by(event_id: params[:event_id], membership_id: params[:membership_id])
        if event_host
          event_host.destroy
          head :no_content
        else
          render json: { error: "Host not found" }, status: :not_found
        end
      end

      private

      def event_host_params
        params.require(:event_host).permit(:event_id, :membership_id)
      end
    end
end
