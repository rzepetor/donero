require "test_helper"

class DonationTest < ActiveSupport::TestCase
  test "perform" do
    assert_difference -> { Donation.count }, 1 do
      Donation::Create.new(donor_name: "michael", declared_amount: 1, message: "You are the best!").perform
    end
  end
end
