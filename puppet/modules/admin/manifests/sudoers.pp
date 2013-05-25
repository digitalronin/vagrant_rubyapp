class admin::sudoers {
  file { "/etc/sudoers":
    mode => 440,
    content => template("admin/sudoers.erb"),
    owner => "root",
    group => "root",
  }
}
