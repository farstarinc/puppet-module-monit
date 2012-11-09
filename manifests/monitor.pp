# == Class: monit::monitor
#
# This module configures a service to be monitored by Monit
#
# === Parameters
#
# [*pidfile*] - Path to the pid file for the service
# [*ensure*]  - If the file should be enforced or not (default: present)
# [*ip_port*] - Port to check if needed (zero to disable)
# [*socket*]  - Path to socket file if needed (undef to disable)
# [*checks*]  - Array of monit check statements
#
# === Examples
#
#  monit::monitor { 'monit-watch-monit':
#    pidfile => '/var/run/monit.pid',
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
define monit::monitor (
  $pidfile,
  $ensure   = present,
  $ip_port  = 0,
  $socket   = '',
  $checks   = [ ],
) {
  include monit::params

  # Template uses: $pidfile, $ip_port, $socket, $checks
  file { "${monit::params::conf_dir}/$name.conf":
    ensure  => $ensure,
    content => template('monit/process.conf.erb'),
    notify  => Service[$monit::params::monit_service],
    require => Package[$monit::params::monit_package],
  }
}
