require_relative 'lib/scale_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'scale_rb'
  spec.version       = ScaleRb::VERSION
  spec.authors       = ['Aki Wu']
  spec.email         = ['wuminzhe@gmail.com']

  spec.summary       = 'A Ruby SCALE Codec Library, and, Substrate RPC Client'
  spec.description   = 'This gem includes a ruby implementation of SCALE Codec, a general Substrate Http JSONRPC Client, and, a general Substrate Websocket JSON-RPC Client.'
  spec.homepage      = 'https://github.com/wuminzhe/scale_rb'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.1') # async gem's requirement

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/wuminzhe/scale_rb/issues/',
    'source_code_uri' => 'https://github.com/wuminzhe/scale_rb.git'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # for hashers
  spec.add_dependency 'base58'
  spec.add_dependency 'blake2b_rs', '~> 0.1.4'
  spec.add_dependency 'xxhash'
  # for websocket client
  spec.add_dependency 'async'
  spec.add_dependency 'async-http', '~> 0.69.0'
  spec.add_dependency 'async-websocket', '~> 0.26.2'
  # for logger
  spec.add_dependency 'console'
  # for types restriction
  spec.add_dependency 'dry-struct'
  spec.add_dependency 'dry-types'
end
