class Donation::ProcessJob < ApplicationJob
  def perform(donation)
    Donation::Process.new(donation:).perform
  end
end
