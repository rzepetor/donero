require "test_helper"

class Transfer::CreateTest < ActiveSupport::TestCase
  include MoneroWalletRpc::TestHelper

  test "transfer not created when txid taken" do
    stub_monero_wallet_rpc_get_transfer_by_txid_request

    txid = transfers(:one).txid

    assert_no_difference -> { Transfer.count } do
      create = Transfer::Create.new(txid: txid)
      create.perform

      assert_not_empty create.errors
      assert create.errors.of_kind?(:existing_transfer, :present)
    end
  end

  test "transfer not created when donation not found" do
    stub_monero_wallet_rpc_get_transfer_by_txid_request

    assert_no_difference -> { Transfer.count } do
      create = Transfer::Create.new(txid: SecureRandom.base58)
      create.perform

      assert_not_empty create.errors
      assert create.errors.of_kind?(:donation, :blank)
    end
  end

  test "successful perform" do
    monero_address = donations(:one).monero_address
    txid = SecureRandom.base58

    stub_monero_wallet_rpc_get_transfer_by_txid_request(monero_address:, amount: 1)

    assert_difference -> { Transfer.count }, 1 do
      create = Transfer::Create.new(txid:)
      create.perform

      assert_empty create.errors
      assert_equal txid, create.transfer.txid
      assert_equal monero_address, create.transfer.monero_address
      assert_equal 1, create.transfer.amount
    end
  end
end
