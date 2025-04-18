class Donation::Create::Form
  include ActiveModel::Model

  attr_accessor :donor_name, :declared_amount, :message

  validates :donor_name, presence: true, length: { maximum: 30 }
  validates :declared_amount, numericality: { greater_than: 0 }
  validates :message, presence: true, length: { maximum: 300 }

  def to_attributes
    { donor_name:, declared_amount:, message: }
  end
end
