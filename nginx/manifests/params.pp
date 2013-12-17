class nginx::params {

  $configdir          = '/etc/nginx'
  $conffile           = 'nginx.conf'
  $pidfile            = 'nginx.pid'

  $user               = 'nginx'

  $workers            = '1'
  $worker_connections = '1024'
  $sendfile           = 'on'
  $tcp_nopush         = 'off'
  $keepalive_timeout  = '65'
  $gzip               = 'off'

  $default_listen     = '80 default'

  case $::operatingssytem {
    'centos' : {
      $packagename  = 'nginx'
      $logdir       = '/var/log/nginx'
      $rundir       = '/var/run'
      $service      = 'nginx'
    }
  }
}
