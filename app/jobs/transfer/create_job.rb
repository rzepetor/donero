class Transfer::CreateJob < ApplicationJob
  def perform(txid)
    Transfer::Create.new(txid:).perform
  end
end
