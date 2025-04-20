class ReflectionTip < ApplicationRecord
    validates :keyword, presence: true
    validates :category, presence: true, inclusion: { in: %w[physical intellectual emotional spiritual] }
    validates :tip, presence: true, uniqueness: true

    has_many :tip_ratings, dependent: :destroy
    has_many :favorite_tips, dependent: :destroy
    has_many :favoriting_users, through: :favorite_tips, source: :user
end
