class Api::V1::PiesEntriesController < ApplicationController
  before_action :current_user

  def index
    entries = current_user.pies_entries.order(checked_in_on: :desc)
    render json: entries
  end

  def create
    pies_entry = current_user.pies_entries.new(pies_entry_params)
    if pies_entry.save
      render json: pies_entry, status: :created
    else
      render json: { errors: pies_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def latest
    entries = current_user.pies_entries.order(created_at: :desc)

    today = Date.current
    today_entry = entries.find { |entry| entry.created_at.to_date == today }

    streak = 0
    streaking = true
    previous_day = today

    entries.each do |entry|
      entry_day = entry.created_at.to_date

      if entry_day == previous_day
        streak += 1
        previous_day -= 1.day
      else
        streaking = false
        break
      end
    end

    render json: {
      last_checkin: entries.first&.created_at&.to_date,
      today_checked_in: today_entry.present?,
      streak_count: streak,
      recent_entries: entries.limit(5).as_json(only: [ :id, :created_at, :physical, :intellectual, :emotional, :spiritual ])
    }
  end
      private


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
