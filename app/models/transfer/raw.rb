class Transfer::Raw
  include ActiveModel::Model

  attr_accessor :txid

  delegate :address, to: :data, allow_nil: true

  alias_attribute :monero_address, :address

  def amount
    data.amount / 1_000_000_000_000.0
  end

  private

  def data
    @data ||= MoneroWalletRpc.get_transfer_by_txid(txid)
  end
end
