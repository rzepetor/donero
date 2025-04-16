class DonationsController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def index
    @pagy, @donations = pagy(Donation.all)
  end

  def new
    @form = Donation::Create::Form.new
  end

  def create
    @form = Donation::Create::Form.new(donation_params)

    if verify_recaptcha(model: @form, attribute: :recaptcha) && @form.valid?
      Donation::Create.new(@form.to_attributes).perform

      redirect_to root_path, success: "Donation have been created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def donation_params
    params.expect(donation: [ :donor_name, :declared_amount, :message ])
  end
end
