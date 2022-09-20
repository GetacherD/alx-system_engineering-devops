# configure server

package { 'nginx':
    ensure => 'installed',
    before => File['error']
}
$err = "Ceci n'est pas une page"
$conf = "server {\n
   listen   80 default_server;\n
   listen   [::]:80 default_server;\n
   root     /var/www/html;\n
   index    index.html index.htm;\n
   location /redirect_me {\n
       return 301 https://www.youtube.com;\n
   }\n
   error_page 404 /custom_404.html;\n
   location = /custom_404.html {\n
        root /var/www/errors/;\n
        internal;\n
   }\n     
}\n
"
$hello = "Hello World!\n"
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
  command => '/usr/bin/service nginx restart',
  after   => File['nginx_conf']
}
