
 package { ['ant', 'maven', 'python-pip']:
   ensure => installed,
 }

package { ['build-essential', 'cmake', 'ghc', 'cabal-install']:
  ensure => installed,
}

package { ['curl', 'wget', 'nmap', 'htop']:
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

package { ['autoenv', 'virtualenv', 'virtualenvwrapper']:
  provider => pip,
  require  => Package['python-pip'],
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


