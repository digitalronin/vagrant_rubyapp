class admin::build_dependencies {

  include admin::apt_get_update

  package { [
      "build-essential",
      "zlib1g-dev",
      "libssl-dev",
      "libreadline-dev",
      "libyaml-dev",
      "libcurl4-openssl-dev",
      "curl",
      "git-core",
      "python-software-properties"
    ]:
    ensure  => installed,
    require => Exec[apt_get_update]
  }
}

