define nginx::vhost (
  $listen     = $nginx::params::default_listen,
  $servername = $name,
  $access_log = undef,
  $locations  = undef,
) {
  file { "${nginx::configdir}/conf.d/pp_${name}.conf" :
    ensure  => file,
    owner   => $nginx::user,
    content => template ( 'nginx/vhost.conf.erb' ),
    notify  => $nginx::service,
    require => Class [ 'nginx::config' ],
  }
}
