class Donation::Process
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :donation

  delegate :recalculate_received_amount, :declared_amount, :received_amount, to: :donation, prefix: true

  before_validation :donation_recalculate_received_amount

  validates :donation_received_amount, comparison: { greater_than_or_equal_to: :donation_declared_amount }

  def perform
    invalid?
  end
end
