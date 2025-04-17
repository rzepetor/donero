class AddMoneroAddressToDonations < ActiveRecord::Migration[8.0]
  def change
    add_column :donations, :monero_address, :string
  end
end
