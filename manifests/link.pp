define systemd_networkd::link (
  String $link_name,
  String $link_description,
  String $ensure = 'present',
  String $match_mac_address = '',
  String $match_original_name = '',
) {

  file { "systemd-link-${link_name}":
    ensure  => $ensure,
    path    => "/etc/systemd/network/10-${link_name}.link",
    content => template('systemd_networkd/link.erb'),
    notify  => Service['systemd-networkd']
  }

}