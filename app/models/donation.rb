class Donation < ApplicationRecord
  self.primary_key = :monero_address

  has_many :transfers, foreign_key: :monero_address
end
