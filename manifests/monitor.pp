define monit::monitor($pidfile,
                      $ensure=present,
                      $ip_port=0,
                      $socket="",
                      $checks=[],
                      $upstart=false) {
  
  $upstart_name = $upstart ? {
    false => undef,
    true => $name,
    default => $upstart,
  }

  file { "/etc/monit/conf.d/$name.conf":
    ensure => $ensure,
    content => template("monit/process.conf.erb"),
    notify => Service["monit"],
    require => Package["monit"],
  }
}
