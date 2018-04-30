#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
params = JSON.parse(STDIN.read)

args = ['bolt', 'task', 'run', params['task'], '--nodes', params['node'], '--params', '-', '--format', 'json', '--modulepath=/etc/puppetlabs/code/modules']
args << ['--user', params['username']] if params['username']
args << ['--password', params['password']] if params['password']

# STDERR.puts args.inspect

require 'open3'
result, errors, status = Open3.capture3(
  *args,
  stdin_data: JSON.generate(params['params']),
  binmode: true,
)

STDERR.puts errors
puts result

exit status.exitstatus
