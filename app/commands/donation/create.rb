class Donation::Create
  include ActiveModel::Model

  attr_accessor :donor_name, :declared_amount, :message, :donation

  def perform
    @donation = create_donation
  end

  private

  def create_donation
    Donation.create!(donor_name:, declared_amount:, message:, monero_address: MoneroWalletRpc.generate_address)
  end
end
