# configure sshd
class sshd(
  $package                             = $sshd::params::package,
  $manage_firewall                     = $sshd::params::manage_firewall,
  $sshd_config_port                    = $sshd::params::sshd_config_port,
  $sshd_config_listen_address          = $sshd::params::sshd_config_listen_address,
  $sshd_config_rsa_key_location        = $sshd::params::sshd_config_rsa_key_location,
  $sshd_config_dsa_key_location        = $sshd::params::sshd_config_dsa_key_location,
  $sshd_config_ecdsa_key_location      = $sshd::params::sshd_config_ecdsa_key_location,
  $sshd_config_ed25519_key_location    = $sshd::params::sshd_config_ed25519_key_location,
  $sshd_config_KeyRegenerationInterval = $sshd::params::sshd_config_KeyRegenerationInterval,
  $sshd_config_ephemeral_key_bits      = $sshd::params::sshd_config_ephemeral_key_bits,
  $sshd_config_syslog_facility         = $sshd::params::sshd_config_syslog_facility,
  $sshd_config_log_level               = $sshd::params::sshd_config_log_level,
  $sshd_config_permit_root_login       = $sshd::params::sshd_config_permit_root_login,
  $sshd_config_strictmodes             = $sshd::params::sshd_config_strictmodes,
  $sshd_config_rsa_auth                = $sshd::params::sshd_config_rsa_auth,
  $sshd_config_pubkey_auth             = $sshd::params::sshd_config_pubkey_auth,
  $sshd_config_ignorerhosts            = $sshd::params::sshd_config_ignorerhosts,
  $sshd_config_rhosts_rsa_auth         = $sshd::params::sshd_config_rhosts_rsa_auth,
  $sshd_config_host_based_auth         = $sshd::params::sshd_config_host_based_auth,
  $sshd_config_ignore_user_known_hosts = $sshd::params::sshd_config_ignore_user_known_hosts,
  $sshd_config_permit_emptypasswords   = $sshd::params::sshd_config_permit_emptypasswords,
  $sshd_config_challenge_response_auth = $sshd::params::sshd_config_challenge_response_auth,
  $sshd_config_x11forwarding           = $sshd::params::sshd_config_x11forwarding,
  $sshd_config_printmotd               = $sshd::params::sshd_config_printmotd,
  $sshd_config_printlastlog            = $sshd::params::sshd_config_printlastlog,
  $sshd_config_tcpkeepalive            = $sshd::params::sshd_config_tcpkeepalive,
  $sshd_config_bannerfile              = $sshd::params::sshd_config_bannerfile,
  $sshd_config_bannersource            = $sshd::params::sshd_config_bannersource,
  $sshd_config_usepam                  = $sshd::params::sshd_config_usepam,
  $sshd_export_keys                    = $sshd::params::sshd_export_keys,
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
