# app/models/event_host.rb
class EventHost < ApplicationRecord
  belongs_to :event
  belongs_to :membership

  validates :membership_id, uniqueness: { scope: :event_id }
end