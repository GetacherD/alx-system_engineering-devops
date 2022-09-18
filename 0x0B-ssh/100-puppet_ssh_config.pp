include stdlib
file_line {'replace_pwd_auth':
  match   => '*PasswordAuthentication*',
  path    => '/etc/ssh/ssh_config',
  line    => '    PasswordAuthentication no',
  replace => true
}

file_line {'replace_identity':
  match   => '*IdentityFile ~/.ssh/id_rsa*',
  path    => '/etc/ssh/ssh_config',
  line    => '    IdentityFile ~/.ssh/school',
  replace => true
}
