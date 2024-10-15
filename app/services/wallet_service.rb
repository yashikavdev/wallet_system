class WalletService
  def self.credit(wallet, amount)
    Transaction.create!(wallet:, amount:, transaction_type: 'credit')
  end

  def self.debit(wallet, amount)
    raise 'Insufficient funds' if wallet.balance < amount

    Transaction.create!(wallet:, amount: -amount, transaction_type: 'debit')
  end

  def self.transfer(source_wallet, target_wallet, amount)
    ApplicationRecord.transaction do
      debit(source_wallet, amount)
      credit(target_wallet, amount)
    end
  end
end
