class DismissedKeyword < ApplicationRecord
  validates :word, :category, :example, presence: true
  validates :word, uniqueness: { scope: :category }
  validates :category, inclusion: { in: %w[physical intellectual emotional spiritual] }
end
