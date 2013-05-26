class mongodb::install {
  package { "mongodb":
    ensure => installed
  }
}
