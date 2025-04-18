class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.string :txid
      t.string :monero_address
      t.decimal :amount, precision: 15, scale: 12

      t.timestamps
    end

    add_index :transfers, :txid, unique: true
  end
end
