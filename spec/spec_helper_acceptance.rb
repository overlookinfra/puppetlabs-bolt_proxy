require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_module_on(hosts)
install_module_dependencies_on(hosts)

hosts.each do |host|
  apply_manifest_on(host, 'include bolt_proxy')
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    on(hosts_as('agent'), "ssh-keygen -f .ssh/id_rsa -N ''")
    on(hosts_as('agent'), 'cat .ssh/id_rsa.pub >> .ssh/authorized_keys')
  end
end
