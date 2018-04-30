# Install bolt into the puppet agent. Since this module is primarily useful in PE
# this class can't use the FOSS bolt packages from the puppet5 repos. Instead it
# installs the gem into the puppet-agent's ruby.
#
# @summary Install bolt into the puppet agent
#
# @example
#   include bolt_proxy
class bolt_proxy {
  package { 'bolt':
    ensure   => installed,
    provider => puppet_gem,
  }
}
