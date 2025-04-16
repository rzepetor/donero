class Donation::Create
  include ActiveModel::Model

  attr_accessor :donor_name, :declared_amount, :message

  def perform
    create_donation
  end

  private

  def create_donation
    Donation.create!(donor_name:, declared_amount:, message:)
  end
end
