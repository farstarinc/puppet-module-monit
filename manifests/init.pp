class monit($ensure=present, $admin="", $interval=60) {
  $is_present = $ensure == "present"

  package { "monit":
    ensure => $ensure,
  }

  file { "/etc/monit/monitrc":
    ensure => $ensure,
    content => template("monit/monitrc.erb"),
    mode => 600,
    require => Package["monit"],
  }

  file { "/etc/default/monit":
    ensure => $ensure,
    content => "startup=1\n",
    require => Package["monit"],
  }

  service { "monit":
    ensure => $is_present,
    enable => $is_present,
    hasrestart => true,
    pattern => "/usr/sbin/monit",
    subscribe => File["/etc/monit/monitrc"],
    require => [File["/etc/nginx/nginx.conf"],
                File["/etc/logrotate.d/nginx"]],
  }
}
