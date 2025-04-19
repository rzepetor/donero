require "test_helper"

class Donation::ProcessTest < ActiveSupport::TestCase
  test "fails with received amount less than declared amount" do
    donation = donations(:one)
    transfers(:one).update(amount: 0.9)

    process = Donation::Process.new(donation: donation)

    assert process.invalid?
    assert process.errors.of_kind?(:donation_received_amount, :greater_than_or_equal_to)
  end
end
