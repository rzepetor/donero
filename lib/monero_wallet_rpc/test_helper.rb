module MoneroWalletRpc::TestHelper
  def stub_monero_wallet_rpc_generate_address_request(monero_address: default_monero_address)
    stub_request(:post, ENV.fetch("MONERO_WALLET_RPC_URL")).
      with { |request| request.body.include?("create_address") }.
      to_return(body: { result: { address: monero_address } }.to_json)
  end

  def stub_monero_wallet_rpc_get_transfer_by_txid_request(monero_address: default_monero_address, amount: 1)
    amount *= 1_000_000_000_000

    stub_request(:post, ENV.fetch("MONERO_WALLET_RPC_URL")).
      with { |request| request.body.include?("get_transfer_by_txid") }.
      to_return(body: { result: { transfer: { address: monero_address, amount: } } }.to_json)
  end

  def default_monero_address
    "7Ayes2yfbZH84ZgxCKW8atGan5NY4SMEjX21yx5tdgL8VPB4zkESenyLxcfbHK7oPu1LiJ7e4AJhcL3bs9LsprJdBRoM9FU"
  end
end
