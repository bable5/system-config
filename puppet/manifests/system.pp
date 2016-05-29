 package { ['ant', 'maven', 'python-pip']:
   ensure => installed,
 }

package { ['build-essential', 'ghc', 'cabal-install']:
  ensure => installed,
}

package { ['curl', 'wget', 'nmap']:
  ensure => installed,
}

package { ['git', 'subversion']:
  ensure => installed,
}

package { ['vim-nox']:
  ensure => installed,
}

package { ['aptitude', 'tmux', 'zsh']:
  ensure => installed,
}

package { ['virtualenv', 'virtualenvwrapper']:
  provider => pip,
  ensure   => installed,
}

