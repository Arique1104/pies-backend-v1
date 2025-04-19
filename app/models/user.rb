class User < ApplicationRecord
  has_secure_password
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :pies_entries, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end