class Api::V1::EventsController < ApplicationController
      before_action :set_organization
      before_action :set_event, only: [:show]

      def index
        @events = @organization.events.includes(:host_memberships)
        render json: @events.as_json(include: { host_memberships: { only: [:id, :role] } })
      end

      def show
        render json: @event
      end

      def create
        @event = @organization.events.new(event_params)
        @event.created_by_membership_id = params[:created_by_membership_id]

        if @event.save
          render json: @event, status: :created
        else
          render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_organization
        @organization = Organization.find(params[:organization_id])
      end

      def set_event
        @event = @organization.events.find(params[:id])
      end

      def event_params
        params.require(:event).permit(:title, :description, :date, :location)
      end
end