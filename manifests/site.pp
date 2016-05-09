node default {
  manageusers::create_account { "user01":
    realname    => "user01",
    uid        => "16400",
    password   => '$6$BwIPxFhj$H8sVaMjoYYUMwXojt/uVdObPuMYKjvLbDNFZ.z1bCFy8DcO7vkWw4lqWAD6tKiAhnrrtntWr3biL4X67cYrq1/',
    shell      => "/bin/bash",
    groups     => ['sudo'],
    sshkeytype => "ssh-rsa",
    sshkey     => "AAAAB3NzaC1yc2EAAAADAQABAAACAQDB51QyzrsKloN72z3YDiFLHcVEe+TyFSv82GiChzd5bijJLFlrqERNsXh816UV6XZ+35hFDASGySOSDI5ZWe5MWA40DFHlyNpYMHxezD3BtJ803WEG8nK4Ze3LPdKLuCdAXhJBoHHrxXBIVwe+B35J5XdMJTxkB6QiVvbSJNNEQat+EbiKSXs5DofP0P7h6nhlIFX3s61ZLS8OLiwMB20fql91td7yKx01FcIDHVJ5f2AJOWybv5wtYkUgDhDNGhTmGK4tMzflRgLnKQtX26wSqa20UnjIsiXTxmiiPgNlUJUIZVzICWjAUCM9ISd8XOK8ezRsxtKu32IRMWE4S4u0DkuLlBI/BVmrbPjFrPY8MsTyGG04V8ejN2+iASNLNKcFBc5Y0zZwmyMUHZfBTz+6rRkrnQ6YgVsc/7qykQ5a237P8sMTaWygdt/pNOGFPz8sCAT2rgH2jPCYKjTwrMgrI2WKL3572mrUwI8q4YMT/hKnzV9dKW+8/o9JlcxtKvvdsEzXH2Lj1KWWIBrrsopNdhnuwRBX+y/nWBDj9DC3ZaHE/4R971JR2EYNiDKr4b6ot4LC0ITLrIq2PibGSx27jxP5sLIbPqzhB7r1U0IOoApRx5ZmOtUoupzdZi9M3QD/rT4VRTLo4oS86QxSUWs//os9yvxIXZzyridWxxiEPw==",
  }

  class { 'server':
    packages        => ['vim', 'htop', 'tree', 'telnet', 'whois', 'screen', 'lvm2', 'mdadm'],
    packages_ensure => 'latest',
    apt_update_interval => 'daily', 
    timezone => 'Europe/Moscow',
    swap_enabled => true,
  }

  firewall { '100 allow http and https access':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }

  include git
  git::config { 'user.name':
    value => 'st01tkh',
  }

  git::config { 'user.email':
    value => 'st01tkh@gmail.com',
  }

  include gitcrypt

  file {"/home/user01/.vimrc":
    content => "filetype plugin indent on\nset tabstop=4\nset shiftwidth=4\nset expandtab\n",
    ensure => 'file',
    owner => 'user01',
    group => 'users',
    mode => 'ug=rw,o=r',
  }

  file {"/home/user01/.ssh":
    ensure => 'directory',
    owner => 'user01',
    group => 'users',
    mode => '0700',
  }

  file {"/home/user01/.ssh/config":
    content => "Host st01tkh.github.com\nHostname github.com\nUser git\n",
    ensure => 'file',
    owner => 'user01',
    group => 'users',
    mode => '0600',
  }
  File["/home/user01/.ssh"]->
  File["/home/user01/.ssh/config"]

  #include syncthing
}
