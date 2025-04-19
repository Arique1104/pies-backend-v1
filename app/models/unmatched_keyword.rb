class UnmatchedKeyword < ApplicationRecord
  validates :word, presence: true
  validates :category, inclusion: { in: %w[physical intellectual emotional spiritual] }
end