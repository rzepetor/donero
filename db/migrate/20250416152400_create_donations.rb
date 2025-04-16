class CreateDonations < ActiveRecord::Migration[8.0]
  def change
    create_table :donations do |t|
      t.string :donor_name
      t.decimal :declared_amount, precision: 15, scale: 12, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
