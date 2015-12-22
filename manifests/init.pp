# configure sshd
class sshd(
  $package         = $sshd::params::package,
  $manage_firewall = $sshd::params::manage_firewall,
  $service         = $sshd::params::service,
  $config_file     = $sshd::params::config_file,
  $config_source   = $sshd::params::config_source,
  $banner_file     = $sshd::params::banner_file,
  $banner_source   = $sshd::params::banner_source,
  )
inherits sshd::params {

  # firewall logic
  if $manage_firewall == true {
    firewall { '100 allow openssh':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '22',
      proto  => 'tcp',
      action => 'accept',
      }
  }

  package { $package:
    ensure => 'installed',
  }

  file { '/etc/ssh/sshd_config':
    source  => template('sshd/sshd_config.erb'),
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => Package[$package],
    notify  => Service[$service],
  }
    
  file {$banner_file:
    ensure => file,
    path   => $banner_file,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => $banner_source,
    }

  service { $service:
    ensure  => 'running',
    enable  => true,
    require => Package[$package],
   }
   


}
