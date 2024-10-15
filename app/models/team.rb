class Team < ApplicationRecord
  has_one :wallet, as: :entity, dependent: :destroy
  after_create :create_wallet
end
