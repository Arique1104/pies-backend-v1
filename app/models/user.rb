class User < ApplicationRecord

after_create :assign_super_user

  has_secure_password
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :pies_entries, dependent: :destroy
  validates :email, presence: true, uniqueness: true

  has_many :tip_ratings, dependent: :destroy
  has_many :favorite_tips, dependent: :destroy

  has_many :favorited_reflection_tips, through: :favorite_tips, source: :reflection_tip

  def assign_super_user
    update(super_user: true) if User.count == 1
  end
  
end
