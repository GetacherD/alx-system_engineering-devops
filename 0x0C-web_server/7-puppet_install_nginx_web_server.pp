# configure new Server

package { 'nginx':
  ensure => 'installed',
}
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

file {'/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => $conf
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!'
}

file { '/var/www/errors/custom_404.html':
  ensure  => 'present',
  content => "Ceci n\'est pas une page"
}

service {'nginx':
  ensure  => running,
  require => Package['nginx']
}
