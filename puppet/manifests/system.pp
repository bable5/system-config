package { ['ant', 'maven', 'python-pip',
  'build-essential', 'cmake', 'ghc', 'cabal-install',
  'python-setuptools']:
  ensure => installed,
}

package { ['libssl-dev']:
  ensure => installed,
}

package { ['curl', 'wget', 'nmap', 'htop',
    'openssh-server', 'molly-guard',
  ]:
  ensure => installed,
}

package { ['git', 'subversion']:
  ensure => installed,
}

package { ['vim-nox']:
  ensure => installed,
}

package { ['aptitude', 'dtrx', 'tmux', 'zsh']:
  ensure => installed,
}

package { ['exfat-fuse', 'exfat-utils']:
  ensure => installed
}

package { ['apt-transport-https', 'ca-certificates']:
  ensure => installed,
}

package { ['autoenv', 'docker-compose', 'virtualenv', 'virtualenvwrapper']:
  provider => pip,
  require  => Package['python-pip', 'python-setuptools'],
  ensure   => installed,
}

package { ['fortune', 'cowsay']:
  ensure => installed,
}

user { 'sean':
  ensure  => present,
  require => Package['zsh'],
  shell   => '/bin/zsh',
}


