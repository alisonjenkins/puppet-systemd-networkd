define systemd_networkd::network (
  String $ensure = 'present',
  String $dhcp_type = 'ipv4',
  String $route_metric = '0',
) {

  $link_name = $name

  file { "systemd-network-${link_name}":
    ensure  => $ensure,
    path    => "/etc/systemd/network/50-${link_name}.network",
    content => template('systemd_networkd/network.erb'),
    notify  => Service['systemd-networkd']
  }

}

