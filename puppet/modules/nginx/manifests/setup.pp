class nginx::setup {
  file { "/etc/init.d/nginx":
    source => "puppet:///modules/nginx/init-script.sh",
    owner  => "root",
    group  => "root",
    mode   => 755
  }

  exec { "create-nginx-service":
    command => "/usr/sbin/update-rc.d -f nginx defaults",
    creates => "/etc/rc2.d/S20nginx"
  }

  file { "/etc/logrotate.d/nginx":
    source => "puppet:///modules/nginx/nginx.logrotate",
  }

  file { [
      "/opt/nginx/conf/sites-available",
      "/opt/nginx/conf/sites-enabled"
    ]:
    ensure => directory,
    owner  => "root",
    group  => "root"
  }

  file { "/opt/nginx/conf/nginx.conf":
    source => "puppet:///modules/nginx/nginx.conf",
    owner  => "root",
    group  => "root",
    mode   => 644
  }

}
