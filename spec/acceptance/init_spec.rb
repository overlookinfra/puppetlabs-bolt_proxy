# run a test task
require 'spec_helper_acceptance'
# bolt regexes
# expect_multiple_regexes(result: result, regexes: [%r{"status":"(stopped|in_sync)"}, %r{Ran on 1 node}])
# expect_multiple_regexes(result: result, regexes: [%r{"status":"stopped"}, %r{"enabled":"false"}, %r{Ran on 1 node}])

def run_and_expect(params, regex_hash)
  expect_multiple_regexes(result: run_task(task_name: 'bolt_proxy', params: params, host: agent.hostname), regexes: regex_hash)
end

describe 'bolt_proxy task' do
  let(:agent) { hosts_as('agent').first }
  let(:task_result) do
    on(agent, '/opt/puppetlabs/puppet/bin/bolt task run --modulepath=/etc/puppetlabs/code/modules bolt_proxy ' \
    '--params=\'{"task":"bolt_proxy::test", "node":"localhost", "params":{"foo":"bar"}}\' --nodes ' + agent.hostname + ' --no-host-key-check')
  end

  it 'executes successfully' do
    expect(task_result.stdout).to match(%r{foo.*(bar)})
    expect(task_result.stdout).to match(%r{Ran on 1 node})
  end
end
