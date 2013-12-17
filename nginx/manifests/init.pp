# Class: nginx
#
# This module manages nginx
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nginx (
  $packagename        = $nginx::params::packagename,
  $workers            = $nginx::params::workers,
  $worker_connections = $nginx::params::worker_connections,
  $sendfile           = $nginx::params::sendfile,
  $keepalive_timeout  = $nginx::params::keepalive_timeout,
  $tcp_nopush         = $nginx::params::tcp_nopush,
  $gzip               = $nginx::params::gzip,
  $puppet_vhost_only  = true,
  $vhosts             = undef,
) inherits nginx::params {

  $configdir = $nginx::params::configdir
  $conffile  = $nginx::params::conffile
  $pidfile   = $nginx::params::pidfile
  $logdir    = $nginx::params::logdir
  $rundir    = $nginx::params::rundir
  $user      = $nginx::params::user
  $service   = $nginx::params::service

  class { 'nginx::install' : }
  class { 'nginx::config' :
    require =>  Class [ 'nginx::install' ],
  }

  if $vhosts != undef {
    create_resources( 'nginx::vhost', $vhosts )
  }

  class { 'nginx::service' :
    require =>  Class [ 'nginx::config' ],
  }
}

class nginx::install {
  package { $nginx::packagename :
    ensure  => present,
  }
}

class nginx::config (
  $configdir          = $nginx::params::configdir,
  $conffile           = $nginx::params::conffile,
  $pidfile            = $nginx::params::pidfile,
  $logdir             = $nginx::params::logdir,
  $rundir             = $nginx::params::rundir,
  $user               = $nginx::params::user,
  $workers            = $nginx::params::workers,
  $worker_connections = $nginx::params::worker_connections,
  $sendfile           = $nginx::params::sendfile,
  $keepalive_timeout  = $nginx::params::keepalive_timeout,
  $tcp_nopush         = $nginx::params::tcp_nopush,
  $gzip               = $nginx::params::gzip,
) {
  file { "${configdir}/${conffile}" :
    ensure  => file,
    content => template ('nginx/nginx.conf.erb'),
    notify  => Service [ $nginx::service ],
  }
  file { "${configdir}/conf.d" :
    ensure  => directory,
  }
  if $nginx::puppet_vhost_only == true {
    File [ "${configdir}/conf.d" ] {
      purge   => true,
      recurse => true,
      ignore  => "pp_*.conf",
    }
  }
}

class nginx::service {
  service { $nginx::service :
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
