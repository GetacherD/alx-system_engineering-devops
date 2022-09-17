$str = 'Include /etc/ssh/ssh_config.d/*.conf\n
Host *\n
    PasswordAuthentication no\n
    IdentityFile ~/.ssh/school\n
    SendEnv LANG LC_*\n
    HashKnownHosts yes\n
    GSSAPIAuthentication yes\n'
file {'/etc/ssh/ssh_config':
    ensure  => 'present',
    content => $str,
    mode    => '0744'
}
