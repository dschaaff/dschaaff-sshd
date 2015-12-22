class sshd::params {
  $manage_firewall                     = hiera('sshd::manage_firewall', false)
  $sshd_config_port                    = hiera('sshd::sshd_config_port','22')
  $sshd_config_listen_address          = hiera('sshd::sshd_config_listen_address', '0.0.0.0')
  $sshd_config_rsa_key_location        = hiera('sshd::sshd_config_rsa_key_location','/etc/ssh/ssh_host_rsa_key')
  $sshd_config_dsa_key_location        = hiera('sshd::sshd_config_dsa_key_location','/etc/ssh/ssh_host_dsa_key')
  $sshd_config_ecdsa_key_location      = hiera('sshd::sshd_config_ecdsa_key_location','/etc/ssh/ssh_host_ecdsa_key')
  $sshd_config_ed25519_key_location    = hiera('sshd::sshd_config_ed25519_key_location','/etc/ssh/ssh_host_ed25519_key')
  $sshd_config_KeyRegenerationInterval = hiera('sshd_config_KeyRegenerationInterval','3600')
  $sshd_config_ephemeral_key_bits      = hiera('sshd_config_ephemeral_key_bits','1024')
  $sshd_config_syslog_facility         = hiera('sshd_config_syslog_facility','AUTH')
  $sshd_config_log_level               = hiera('sshd_config_log_level','INFO')
  $sshd_config_permit_root_login       = hiera('sshd::sshd_config_permit_root_login','yes')
  $sshd_config_strictmodes             = hiera('sshd::sshd_config_strictmodes', 'yes')
  $sshd_config_rsa_auth                = hiera('sshd::sshd_config_rsa_auth','yes')
  $sshd_config_pubkey_auth             = hiera('sshd::sshd_config_pubkey_auth','yes')
  $sshd_config_ignorerhosts            = hiera('sshd::sshd_config_ignorerhosts', 'yes')
  $sshd_config_rhosts_rsa_auth         = hiera('sshd::sshd_config_rhosts_rsa_auth','no')
  $sshd_config_host_based_auth         = hiera('sshd::sshd_config_host_based_auth','no')
  $sshd_config_ignore_user_known_hosts = hiera('sshd::sshd_config_ignore_user_known_hosts', 'no')
  $sshd_config_permit_emptypasswords   = hiera('sshd:sshd_config_permit_emptypasswords', 'no')
  $sshd_config_challenge_response_auth = hiera('sshd::sshd_config_challenge_response_auth', 'no')
  $sshd_config_x11forwarding           = hiera('sshd::sshd_config_x11forwarding', 'yes')
  $sshd_config_printmotd               = hiera('sshd::sshd_config_printmotd', 'yes')
  $sshd_config_printlastlog            = hiera('sshd::sshd_config_printlastlog', 'yes')
  $sshd_config_tcpkeepalive            = hiera('sshd::sshd_config_tcpkeepalive', 'yes')
  $sshd_config_bannerfile              = hiera('sshd::sshd_config_bannerfile', undef)
  $sshd_config_bannersource            = hiera('sshd::sshd_config_bannersource', undef)
  $sshd_config_usepam                  = hiera('sshd::sshd_config_usepam', 'yes')
  $sshd_export_keys                    = hiera('sshd::sshd_export_keys', false)
  case $::osfamily {
    Debian: {
      $package        = 'openssh-server'
      $service        = 'ssh'
      $config_file    = '/etc/ssh/sshd_config'
    }
    RedHat: {
      $package        = 'openssh-server'
      $service        = 'sshd'
      $config_file    = '/etc/ssh/sshd_config'
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}/${::kernelrelease}")
    }
  }
}