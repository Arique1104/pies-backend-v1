class ReflectionTip < ApplicationRecord
    validates :keyword, presence: true
    validates :category, presence: true, inclusion: { in: %w[physical intellectual emotional spiritual] }
    validates :tip, presence: true, uniqueness: true
end
