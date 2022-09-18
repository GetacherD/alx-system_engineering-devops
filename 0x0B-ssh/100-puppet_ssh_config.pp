file_line {'replace_pwd_auth':
  path    => '/etc/ssh/ssh_config',
  line    => '    PasswordAuthentication no'
}

file_line {'replace_identity':
  path    => '/etc/ssh/ssh_config',
  line    => '    IdentityFile ~/.ssh/school'
}
