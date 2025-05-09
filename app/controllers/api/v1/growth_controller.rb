# app/controllers/api/v1/growth_controller.rb
class Api::V1::GrowthController < ApplicationController
  before_action :authorize_user

  def summary
    entries = @current_user.pies_entries.order(created_at: :asc)

    if entries.size < 2
      render json: { message: "Add at least one more PIES check-in to start tracking your growth." }, status: :ok
      return
    end

    averages = calculate_averages(entries)
    today = entries.last
    previous = entries[-2]

    insights = generate_insights(previous, today)

    render json: {
      average_scores: averages,
      previous_scores: extract_scores(previous),
      today_scores: extract_scores(today),
      insights: insights,
      entries: entries
    }, status: :ok
  end

  private

  def extract_scores(entry)
    {
      physical: entry.physical,
      intellectual: entry.intellectual,
      emotional: entry.emotional,
      spiritual: entry.spiritual
    }
  end

  def calculate_averages(entries)
    count = entries.size.to_f
    {
      physical: entries.sum(&:physical) / count,
      intellectual: entries.sum(&:intellectual) / count,
      emotional: entries.sum(&:emotional) / count,
      spiritual: entries.sum(&:spiritual) / count
    }
  end

  def generate_insights(previous, today)
    categories = %i[physical intellectual emotional spiritual]
    insights = []

    categories.each do |cat|
      prev = previous.send(cat)
      curr = today.send(cat)

      if curr > prev
        insights << "Nice work! You’ve improved your #{cat} from #{prev} to #{curr}. Keep it up!"
      elsif curr <= prev - 2
        insights << "Your #{cat} score dropped significantly from #{prev} to #{curr}. Take time to reflect or check the Tips tab for support."
      end
    end

    insights
  end
end
