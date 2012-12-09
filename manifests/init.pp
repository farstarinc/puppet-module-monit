# == Class: monit
#
# This module controls Monit
#
# === Parameters
#
# [*ensure*]    - If you want the service running or not
# [*admin*]     - Admin email address
# [*interval*]  - How frequently the check runs
# [*delay*]     - How long to wait before actually performing any action
# [*logfile*]   - What file for monit use for logging
# [*mailserver] - Which mailserver to use
# === Examples
#
#  class { 'monit':
#    admin    => 'me@mydomain.local',
#    interval => 30,
#  }
#
# === Authors
#
# Eivind Uggedal <eivind@uggedal.com>
# Jonathan Thurman <jthurman@newrelic.com>
#
# === Copyright
#
# Copyright 2011 Eivind Uggedal <eivind@uggedal.com>
#
class monit (
  $ensure     = present,
  $admin      = undef,
  $interval   = 60,
  $delay      = $interval * 2,
  $logfile    = $monit::params::logfile,
  $mailserver = 'localhost', 
) inherits monit::params {

  $conf_include = "${monit::params::conf_dir}/*"

  if ($ensure == 'present') {
    $run_service = true
    $service_state = 'running'
  } else {
    $run_service = false
    $service_state = 'stopped'
  }

  package { $monit::params::monit_package:
    ensure => $ensure,
  }

  # Template uses: $admin, $conf_include, $interval, $logfile
  file { $monit::params::conf_file:
    ensure  => $ensure,
    content => template('monit/monitrc.erb'),
    mode    => '0600',
    require => Package[$monit::params::monit_package],
    notify  => Service[$monit::params::monit_service],
  }

  file { $monit::params::conf_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # Not all platforms need this
  if ($monit::params::conf_default) {
    file { $monit::params::conf_default:
      ensure  => $ensure,
      content => "startup=1\n",
      require => Package[$monit::params::monit_package],
    }
  }

  # Template uses: $logfile
  file { $monit::params::logrotate_script:
    ensure  => $ensure,
    content => template("monit/${monit::params::logrotate_source}"),
    require => Package[$monit::params::monit_package],
  }

  service { $monit::params::monit_service:
    ensure     => $service_state,
    enable     => $run_service,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File[$monit::params::conf_file],
    require    => [
      File[$monit::params::conf_file],
      File[$monit::params::logrotate_script]
    ],
  }
}
