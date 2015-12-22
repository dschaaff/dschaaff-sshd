# this updates the known hosts file for users
class sshd::knownhosts {
  Sshkey <<| |>> {ensure => present }
}