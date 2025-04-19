class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  ROLES = %w[member leader manager].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :organization_id }
end