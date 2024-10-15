class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :transactions

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def balance
    transactions.sum(:amount)
  end
end
