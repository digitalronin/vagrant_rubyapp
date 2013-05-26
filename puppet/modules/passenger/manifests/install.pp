class passenger::install {
  package { "passenger":
    provider => "gem",
    ensure   => installed,
    require  => Exec["build-ruby"]
  }

  exec { "install-nginx-module":
    command => "/usr/local/bin/passenger-install-nginx-module -auto --auto-download --prefix /opt/nginx",
    creates => "/opt/nginx/sbin/nginx",
    require => Package[passenger]
  }
}
