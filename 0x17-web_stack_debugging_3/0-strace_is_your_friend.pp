#fix missing index.html file
file {'index':
  ensure  => present,
  path    => '/var/www/html/index.html',
  content => 'Hello Holberton'
}
