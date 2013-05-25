class appuser {
  include admin::sudoers

  user_homedir_hash { "appuser":
    fullname => "Application user",
    myuid => 1108,
    hash => '$6$pyXhadJ/$/WbMEU34PZi4N1Dpo4ryw7WYGKY83gwXv3saMukreP/u5Jz44EduvudZerU9ZxFN.T9cclrHtEcF8d9L40YnK1'
  }

  define user_homedir_hash ($fullname, $myuid, $hash) {
    user { "$name":
      uid     => "$myuid",
      comment => "$fullname",
      home    => "/home/$name",
      shell   => "/bin/bash"
    }

    exec { "$name homedir":
      command => "cp -R /etc/skel /home/$name; chown -R $name /home/$name",
      path => "/bin:/usr/sbin",
      creates => "/home/$name",
      require => User[$name],
    }

    exec { "$name hash":
      command => "/bin/echo '$hash' | /usr/sbin/usermod --password `cat /dev/stdin` $name",
      require => User[$name],
    }

    file { "SSH directory for $name":
      path    => "/home/$name/.ssh",
      owner   => $name, group => $name,
      ensure  => directory,
      mode    => 700,
      require => Exec["$name homedir"],
    }

    file { "Authorized_keys file for $name":
      # If you have a modules/user/files/fred-authorized_keys
      # this will be used, otherwise only your fred.pub key
      # will be authorized
      path    => "/home/$name/.ssh/authorized_keys",
      owner   => $name, group => $name,
      ensure  => present,
      replace => true,
      mode    => 644,
      source  => [ "puppet:///modules/appuser/${name}-authorized_keys", "puppet:///modules/appuser/${name}.pub", "puppet:///modules/appuser/empty.pub" ],
    }

    append_if_no_such_line { "Set umask 002 for $name":
      file    => "/home/$name/.bashrc",
      line    => "umask 002"
    }
  }
}
