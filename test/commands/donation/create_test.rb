require "test_helper"

class DonationTest < ActiveSupport::TestCase
  include MoneroWalletRpc::TestHelper

  test "perform" do
    stub_monero_wallet_rpc_generate_address_request

    assert_difference -> { Donation.count }, 1 do
      creator = Donation::Create.new(donor_name: "michael", declared_amount: 1, message: "You are the best!")
      creator.perform

      assert_equal default_monero_address, creator.donation.monero_address
    end
  end
end
