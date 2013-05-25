vagrant_ruby193
===============

Vagrantfile and puppet recipes to create an Ubuntu 12.04 VM with ruby 1.9.3

Pre-requisites
--------------

* VirtualBox and Vagrant (more info. at http://www.vagrantup.com/)

* The 'precise64' Vagrant box. If you don't have it already, you should be able to install it like this;

    vagrant box add precise64 http://files.vagrantup.com/precise64.box

Installation
------------

    $ git clone git://github.com/digitalronin/vagrant_ruby193.git

    $ cd vagrant_ruby193

    $ vagrant up   # <--- setup the vm and install all software via puppet

    $ vagrant ssh  # <--- ssh onto the vm

    $ vagrant halt # <--- shutdown the vm

    $ vagrant destroy # <--- destroy the vm

Any files you create in the vagrant_ruby193 directory will be
accessible on the vm in the /vagrant directory.

Replacing the public key
------------------------

This project contains my SSH public key. This is because I use this set of puppet recipes to configure live servers when I have finished developing locally using Vagrant. If you want to do the same thing, you will need to replace the contents of;

    puppet/modules/appuser/files/appuser-authorized_keys

...with your own SSH public key. Otherwise, I'll be able to login to your servers as appuser, but you won't.

