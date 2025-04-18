class Transfer::Create
  include ActiveModel::Model

  attr_accessor :txid, :transfer

  delegate :monero_address, :amount, to: :transfer_raw, allow_nil: true

  validates :existing_transfer, absence: true
  validates :donation, presence: true

  def perform
    return if invalid?

    @transfer = create_transfer
  end

  private

  def create_transfer
    donation.transfers.create!(txid:, amount:)
  end

  def donation
    @donation ||= Donation.find_by(monero_address:)
  end

  def existing_transfer
    @existing_transfer ||= Transfer.find_by(txid:)
  end

  def transfer_raw
    @transfer_raw ||= Transfer::Raw.new(txid:)
  end
end
