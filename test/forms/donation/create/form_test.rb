require "test_helper"

class Donation::Create::FormTest < ActiveSupport::TestCase
  setup do
    @form = Donation::Create::Form.new
  end

  test "invalid with blank donor name" do
    @form.donor_name = ""

    assert @form.invalid?
    assert @form.errors.of_kind?(:donor_name, :blank)
  end

  test "invalid with too long donor name" do
    @form.donor_name = "a" * 31

    assert @form.invalid?
    assert @form.errors.of_kind?(:donor_name, :too_long)
  end

  test "invalid with declared amount not a number" do
    @form.declared_amount = ""

    assert @form.invalid?
    assert @form.errors.of_kind?(:declared_amount, :not_a_number)
  end

  test "invalid with declared amount less than or equal to zero" do
    @form.declared_amount = 0

    assert @form.invalid?
    assert @form.errors.of_kind?(:declared_amount, :greater_than)
  end

  test "invalid with blank message" do
    @form.message = ""

    assert @form.invalid?
    assert @form.errors.of_kind?(:message, :blank)
  end

  test "invalid with too long message" do
    @form.message = "a" * 301

    assert @form.invalid?
    assert @form.errors.of_kind?(:message, :too_long)
  end

  test "valid" do
    @form.donor_name = "michael"
    @form.declared_amount = 1
    @form.message = "You are the best!"

    assert @form.valid?
  end
end
