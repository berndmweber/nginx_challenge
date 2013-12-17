class { 'nginx' :
  vhosts          => {
    'example.com' => {
      listen      =>  '8080 default',
      locations   =>  [{
        name      =>  '/',
        root      =>  '/var/www/vhosts/example.com',
        index     =>  'index.html'
        }]
    }
  }
}
