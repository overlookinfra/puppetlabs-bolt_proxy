# Install bolt into the puppet agent. Since this module is primarily useful in PE
# this class can't use the FOSS bolt packages from the puppet5 repos. Instead it
# installs the gem into the puppet-agent's ruby.
#
# @summary Install bolt into the puppet agent
#
# @example
#   include bolt_proxy
class bolt_proxy {
  case $facts['os']['family'] {
    'debian': {
      $dev_packages = [ 'make', 'gcc', 'ruby-dev']
    }
    'redhat': {
      $dev_packages = [ 'make', 'gcc', 'ruby-devel']
    }
    default: { }
  }

  if $dev_packages {
    package {
      $dev_packages:
        ensure => installed,
    }
  }

  package { 'bolt':
    ensure   => installed,
    provider => puppet_gem,
    require  => Package[$dev_packages]
  }
}
