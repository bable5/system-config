 package { ['ant', 'maven']:
   ensure => installed,
 }

package { ['build-essential', 'ghc']:
  ensure => installed
}

package { ['git', 'subversion']:
  ensure => installed
}

package { ['vim-nox']:
  ensure => installed
}

