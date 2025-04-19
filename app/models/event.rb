class Event < ApplicationRecord
  belongs_to :organization
  belongs_to :created_by_membership, class_name: "Membership"

  has_many :event_hosts, dependent: :destroy
  has_many :host_memberships, through: :event_hosts, source: :membership

  validates :title, :date, presence: true
end