class admin::apt_get_update {
  exec { "apt_get_update":
    command => "/usr/bin/apt-get -y update"
  }
}
