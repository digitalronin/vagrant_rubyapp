class ruby193::build {
  package { "libyaml-ruby":
    ensure => installed
  }

  file { "/root/build-ruby.sh":
    source  => "puppet:///modules/ruby193/build-ruby.sh",
    owner   => "root",
    group   => "root",
    mode    => 755,
    require => Package["libyaml-ruby"]
  }

  exec { "build-ruby":
    command => "/root/build-ruby.sh",
    cwd     => "/root",
    timeout => 0,
    creates => "/usr/local/bin/ruby",
    require => [Package["build-essential"], File["/root/build-ruby.sh"]]
  }

  package { "bundler":
    provider => gem,
    ensure   => installed,
    require  => Exec["build-ruby"]
  }
}
