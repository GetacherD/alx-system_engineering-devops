package {'sed':
ensure => 'installed'
}
exec {'update pass':
  command => "usr/bin/sed 's/#   PasswordAuthentication yes/   PasswordAuthentication no/' /etc/ssh/ssh_config",
  require => Package['sed']
}
exec {'update key':
command => 'usr/bin/sed 's/#   IdentityFile ~/.ssh/id_rsa/   IdentityFile ~/.ssh/school/' /etc/ssh/ssh_config",
require => Package['sed']
}
