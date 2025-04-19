class AddReceivedAmountToDonations < ActiveRecord::Migration[8.0]
  def change
    add_column :donations, :received_amount, :decimal, precision: 15, scale: 12, default: 0.0
  end
end
