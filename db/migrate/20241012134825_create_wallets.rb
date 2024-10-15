class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :entity_type
      t.integer :entity_id
      t.decimal :balance, default: 0.0
      t.timestamps
    end
    add_index :wallets, %i[entity_type entity_id]
  end
end
