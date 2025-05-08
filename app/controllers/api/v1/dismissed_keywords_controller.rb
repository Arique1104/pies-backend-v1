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
            keyword.destroy

            UnmatchedKeyword.find_or_create_by!(word: rescued_word, category: rescued_category) do |kw|
                kw.count = 1
                kw.example = "rescued keyword"
            end
            head :no_content
        else
            render json: { error: "Keyword not found" }, status: :not_found
        end
    end

    def create
        keyword = DismissedKeyword.find_or_create_by!(word: params[:word], category: params[:category])
        render json: keyword, status: :created
        rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

end