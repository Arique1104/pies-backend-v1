class TipRating < ApplicationRecord
  belongs_to :user
  belongs_to :reflection_tip
    validates :user_id, uniqueness: { scope: :reflection_tip_id }
end
