class Api::TransfersController < ApiController
  def create
    if txid.present?
      Transfer::CreateJob.perform_later(txid)
    else
      render json: { error: "txid is required" }, status: :unprocessable_content
    end
  end

  private

  def txid
    params.fetch(:txid, nil)
  end
end
