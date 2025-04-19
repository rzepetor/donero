class Donation::ReceivedAmount::Recalculate
  include ActiveModel::Model

  attr_accessor :donation

  def perform
    update_donation_received_amount
  end

  private

  def update_donation_received_amount
    donation.update!(received_amount: donation.transfers.sum(:amount))
  end
end
