# fix maximum concurrent connection 

exec {'fix-max-conc':
  command => "/bin/sed -i 's/.*ULIMIT.*/ULIMIT=\"-n 4096\"/' /etc/default/nginx"
  }

exec {'restart-nginx':
  command => '/usr/sbin/service nginx restart';
}
