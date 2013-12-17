class nginx::params {

  $configdir          = '/etc/nginx'
  $conffile           = 'nginx.conf'
  $pidfile            = 'nginx.pid'
  $vhost_base_dir     = '/var/www/vhosts'

  $user               = 'nginx'

  $workers            = '1'
  $worker_connections = '1024'
  $sendfile           = 'on'
  $tcp_nopush         = 'off'
  $keepalive_timeout  = '65'
  $gzip               = 'off'

  $default_listen     = '80 default'

  case $::operatingsystem {
    'CentOS' : {
      $packagename  = 'nginx'
      $logdir       = '/var/log/nginx'
      $rundir       = '/var/run'
      $service      = 'nginx'
    }
  }
}
