class AddWallet < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.decimal :balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
