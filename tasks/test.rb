#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
params = JSON.parse(STDIN.read)

result = {
  pwd: Dir.pwd,
  env: ENV.to_hash,
  params: params,
}

puts JSON.generate(result)
