class Donation < ApplicationRecord
  self.primary_key = :monero_address

  has_many :transfers, foreign_key: :monero_address


  def process_later
    Donation::ProcessJob.perform_later(self)
  end

  def recalculate_received_amount
    Donation::ReceivedAmount::Recalculate.new(donation: self).perform
  end
end
