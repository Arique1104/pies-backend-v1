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
end