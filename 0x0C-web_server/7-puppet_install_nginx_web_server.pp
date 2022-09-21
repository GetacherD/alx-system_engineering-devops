# configure server

package { 'nginx':
    ensure => 'installed',
    before => File['error']
}
$err = "Ceci n'est pas une page"
$conf = "server {
   listen   80 default_server;
   listen   [::]:80 default_server;
   root     /var/www/html;
   index    index.html index.htm;
   location /redirect_me {
       return 301 https://www.youtube.com;
   }
   error_page 404 /custom_404.html;
   location = /custom_404.html {
        root /var/www/errors/;
        internal;
   }
}
"
$hello = "Hello World!"
file {'error':
  ensure  => 'present',
  path    => '/var/www/errors/custom_404.html',
  content => $err,
  before  => File['index']
}
file { 'index':
  ensure  => 'present',
  path    => '/var/www/html/index.html',
  content => $hello,
  before  => File['nginx_conf']
}
file { 'nginx_conf':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  content => $conf,
  before  => Exec['restart']
}
exec { 'restart':
  path    => ['/usr/bin/', '/usr/sbin/'],
  command => 'service nginx restart',
  after   => File['nginx_conf']
}

