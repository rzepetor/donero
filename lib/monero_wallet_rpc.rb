require "ostruct"

class MoneroWalletRpc
  include ActiveModel::Model

  attr_accessor :method, :params

  def self.generate_address
    new(method: :create_address).response.result.address
  end

  def response
    JSON.parse(request.body, object_class: OpenStruct)
  end

  def request
    Faraday.post(ENV.fetch("MONERO_WALLET_RPC_URL"), body.to_json, headers)
  end

  def body
    { json_rpc: "2.0", id: "0", method: method, params: params }
  end

  def headers
    { "Content-Type" => "application/json" }
  end
end
