class Api::V1::DismissedKeywordsController < ApplicationController
    before_action :authorize_owner!
    def index
        keywords = DismissedKeyword.order(:category, :word)
        render json: keywords
    end

    def destroy
    keyword = DismissedKeyword.find_by(word: params[:id])
        if keyword
            rescued_word = keyword.word
            rescued_category = keyword.category
            rescued_example = keyword.example
            keyword.destroy

            unmatched = UnmatchedKeyword.find_or_initialize_by(word: rescued_word, category: rescued_category)

            unmatched.example ||= rescued_example.presence || "Rescued dismissed keyword"
            unmatched.count ||= 0
            unmatched.count += 1

            unmatched.save!

            head :no_content
        else
            render json: { error: "Keyword not found" }, status: :not_found
        end
    end

    def create
        keyword = DismissedKeyword.find_or_create_by!(word: params[:word], category: params[:category], example: params[:example])
        render json: keyword, status: :created
        rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
