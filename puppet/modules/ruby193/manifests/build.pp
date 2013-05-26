class ruby193::build {
  file { "/root/build-ruby.sh":
    source => "puppet:///modules/ruby193/build-ruby.sh",
    owner  => "root",
    group  => "root",
    mode   => 755
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
