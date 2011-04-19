define monit::monitor($pidfile,
                      $ensure=present,
                      $ip_port=0,
                      $socket="",
                      $checks=[]) {

  file { "/etc/monit/conf.d/$name.conf":
    content => template("monit/process.conf.erb"),
    notify => Service["monit"],
  }
}
