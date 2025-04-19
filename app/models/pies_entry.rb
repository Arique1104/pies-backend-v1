class PiesEntry < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true

  validates :checked_in_on, presence: true

  with_options numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_nil: true do
    validates :physical
    validates :intellectual
    validates :emotional
    validates :spiritual
  end

  after_save :detect_unmatched_keywords

  private

  def detect_unmatched_keywords
    categories = {
      physical: physical_description,
      intellectual: intellectual_description,
      emotional: emotional_description,
      spiritual: spiritual_description
    }

    categories.each do |category, text|
      next unless text.present?

      extract_keywords(text).each do |word|
        next if DismissedKeyword.exists?(word: word)
        next if ReflectionTip.exists?(keyword: word)

        unmatched = UnmatchedKeyword.find_or_initialize_by(word: word, category: category)
        unmatched.count ||= 0
        unmatched.count += 1
        unmatched.example ||= text
        unmatched.save!
      end
    end
  end

  def extract_keywords(text)
    text.downcase.scan(/\b[a-z]{4,}\b/) # Basic filtering
        .uniq - default_stopwords
  end

  def default_stopwords
    %w[about with from that this they their just very have your into also much even more been like]
  end
end