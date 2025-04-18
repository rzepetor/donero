require "test_helper"

class Api::TransfersControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @txid = SecureRandom.base58
  end

  test "unauthorized access to transfers" do
    post api_transfers_path

    assert_response :unauthorized
  end

  test "create transfer fails without txid" do
    post api_transfers_path, params: { txid: "" }, headers: api_authorization_header

    assert_response :unprocessable_content
    assert_equal({ "error" => "txid is required" }, JSON.parse(body))
  end

  test "create transfer successful" do
    assert_enqueued_with job: Transfer::CreateJob, args: [ @txid ] do
      post api_transfers_path, params: { txid: @txid }, headers: api_authorization_header

      assert_response :no_content
    end
  end
end
