class Transfer < ApplicationRecord
  self.primary_key = :txid

  belongs_to :donation, foreign_key: :monero_address
end
