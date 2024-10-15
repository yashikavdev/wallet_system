class User < ApplicationRecord
  has_secure_password
  has_one :wallet, as: :entity, dependent: :destroy
  after_create :create_wallet
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
