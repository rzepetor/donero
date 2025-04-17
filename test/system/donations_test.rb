require "application_system_test_case"

class DonationsTest < ApplicationSystemTestCase
  include MoneroWalletRpc::TestHelper

  test "create donation fails with blank donor name" do
    submit_donation_form

    assert_text "Donor name can't be blank"
  end

  test "create donation fails with too long donor name" do
    submit_donation_form do
      fill_in :donation_donor_name, with: "a" * 31
    end

    assert_text "Donor name is too long (maximum is 30 characters)"
  end

  test "create donation fails with declared amount not a number" do
    submit_donation_form

    assert_text "Declared amount is not a number"
  end

  test "create donation fails with declared amount less than or equal to zero" do
    submit_donation_form do
      fill_in :donation_declared_amount, with: 0
    end

    assert_text "Declared amount must be greater than 0"
  end

  test "create donation fails with blank message" do
    submit_donation_form

    assert_text "Message can't be blank"
  end

  test "create donation fails with too long message" do
    submit_donation_form do
      fill_in :donation_message, with: "a" * 301
    end

    assert_text "Message is too long (maximum is 300 characters)"
  end

  test "create donation fails with invalid reCAPTCHA" do
    verify_recaptcha do
      submit_donation_form

      assert_text "reCAPTCHA was incorrect, please try again."
    end
  end

  test "create donation successfully" do
    stub_monero_wallet_rpc_generate_address_request

    submit_donation_form do
      fill_in :donation_donor_name, with: "michael"
      fill_in :donation_declared_amount, with: 1
      fill_in :donation_message, with: "You are the best!"
    end

    assert_text "Donation have been created"
  end

  private

  def submit_donation_form
    visit root_path
    yield if block_given?
    click_button "Submit"
  end
end
