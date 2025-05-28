class Membership < ApplicationRecord
  # before_create :generate_api_token

  belongs_to :user
  belongs_to :organization

  has_many :event_hosts, dependent: :destroy
  has_many :hosted_events, through: :event_hosts, source: :event

  ROLES = %w[member leader organizer manager owner].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :organization_id }

  # def generate_api_token
  #   self.api_token = SecureRandom.hex(20)
  # end
end
