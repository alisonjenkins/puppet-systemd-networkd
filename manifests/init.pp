# Class: systemd_networkd
# ===========================
#
# Full description of class systemd_networkd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'systemd_networkd':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class systemd_networkd(
  Boolean $use_resolved = false,
){

  ensure_resource('service', 'systemd-networkd', { 'ensure' => 'running', 'enable' => true })

  if ($use_resolved) {
    ensure_resource('service', 'systemd-resolved', { 'ensure' => 'running', 'enable' => true })

    file { 'symlink resolv.conf to systemd-resolved resolv.conf':
      ensure  => link,
      path    => '/etc/resolv.conf',
      target  => '/run/systemd/resolve/resolv.conf',
      replace => true,
    }
  } else {
    ensure_resource('service', 'systemd-resolved', { 'ensure' => 'stopped', 'enable' => false })
  }

}
