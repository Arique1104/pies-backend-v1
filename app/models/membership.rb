class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  has_many :event_hosts, dependent: :destroy
  has_many :hosted_events, through: :event_hosts, source: :event

  ROLES = %w[member leader manager].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :organization_id }
end