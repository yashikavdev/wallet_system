class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true
  validates :transaction_type, inclusion: { in: %w[credit debit] }

  after_create :update_wallet_balance

  private

  def update_wallet_balance
    if transaction_type == 'credit'
      wallet.update!(balance: wallet.balance + amount)
    elsif transaction_type == 'debit'
      wallet.update!(balance: wallet.balance - amount)
    end
  end
end
