class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, foreign_key: true
      t.decimal :amount
      t.string :transaction_type
      t.references :target_wallet, index: true, foreign_key: { to_table: :wallets }
      t.timestamps
    end
  end
end
