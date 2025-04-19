require "test_helper"

class Donation::ReceivedAmount::RecalculateTest < ActiveSupport::TestCase
  test "successful perform" do
    donation = donations(:one)
    transfers_amount_sum = donation.transfers.sum(:amount)

    donation.update(received_amount: 0)

    assert_changes -> { donation.reload.received_amount }, from: 0, to: transfers_amount_sum do
      donation.recalculate_received_amount
    end
  end
end
