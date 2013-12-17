class { 'nginx' :
  vhosts          => {
    'example.com' => {
      listen      =>  '8090 default',
      locations   =>  [{
        name      =>  '/',
        root      =>  '/var/www/vhosts/example.com',
        index     =>  'index.html'
        }]
    }
  }
}
file { '/var/www/vhosts/example.com' :
  ensure    => directory,
  subscribe => File [ '/var/www/vhosts' ],
}
exec { 'pull_index.html' :
  path    => '/bin:/usr/bin:/usr/local/bin',
  cwd     => '/var/www/vhosts/example.com',
  command => 'wget https://raw.github.com/puppetlabs/exercise-webpage/master/index.html',
  unless  => 'test -e /var/www/vhosts/example.com/index.html',
  require =>  File [ '/var/www/vhosts/example.com' ],
}
