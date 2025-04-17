module MoneroWalletRpc::TestHelper
  def stub_monero_wallet_rpc_generate_address_request(address = default_monero_address)
    stub_request(:post, ENV.fetch("MONERO_WALLET_RPC_URL")).
      to_return(body: { result: { address: } }.to_json)
  end

  def default_monero_address
    "7Ayes2yfbZH84ZgxCKW8atGan5NY4SMEjX21yx5tdgL8VPB4zkESenyLxcfbHK7oPu1LiJ7e4AJhcL3bs9LsprJdBRoM9FU"
  end
end
