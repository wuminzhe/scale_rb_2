require 'scale_rb'

ScaleRb.logger.level = Logger::DEBUG

# the commented code below is the same as the code above
ScaleRb::WsClient.start('wss://polkadot-rpc.dwellir.com') do |client|
  block_hash = client.chain_getBlockHash(21585684)
  # block_hash = client.request('chain_getBlockHash', [21585684])

  runtime_version = client.state_getRuntimeVersion(block_hash)
  # runtime_version = client.request('state_getRuntimeVersion', [block_hash])

  puts runtime_version
end
