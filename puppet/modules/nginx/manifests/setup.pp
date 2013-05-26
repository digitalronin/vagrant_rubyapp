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
}
