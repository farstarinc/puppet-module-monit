# Class: monit::params
#
# This module manages Monit paramaters
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class monit::params {

  # OS Specific variables
  case $::osfamily {
    'RedHat': {
      $conf_file        = '/etc/monit.conf'
      $conf_dir         = '/etc/monit.d'
      $default_conf     = undef
      $monit_package    = 'monit'
      $monit_service    = 'monit'
      $logfile          = '/var/log/monit'
      $logrotate_script = '/etc/logrotate.d/monit'
      $logrotate_source = "logrotate.redhat.erb"
      $default_conf_tpl = undef
    }
    'Debian': {
      $conf_file        = '/etc/monit/monitrc'
      $conf_dir         = '/etc/monit/conf.d'
      $default_conf     = '/etc/default/monit'
      $monit_package    = 'monit'
      $monit_service    = 'monit'
      $logfile          = '/var/log/monit.log'
      $logrotate_script = '/etc/logrotate.d/monit'
      $logrotate_source = 'logrotate.debian.erb'
      $default_conf_tpl ='monit.default.conf.ubuntu.maverick.erb'
    }
    'Ubuntu': {
      $conf_file        = '/etc/monit/monitrc'
      $conf_dir         = '/etc/monit/conf.d'
      $default_conf     = '/etc/default/monit'
      $monit_package    = 'monit'
      $monit_service    = 'monit'
      $logfile          = '/var/log/monit.log'
      $logrotate_script = '/etc/logrotate.d/monit'
      $logrotate_source = 'logrotate.ubuntu.erb'
      case $::operatingsystemrelease {
        "10.10": { $default_conf_tpl = 'monit.default.conf.ubuntu.maverick.erb' }
        "12.04": { $default_conf_tpl = 'monit.default.conf.ubuntu.precise.erb'}
         default: { fail("Unsupported osfamily: ${::osfamily} / ${::operatingsystemrelease}") }
       }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
