# Fix for "Could not find group puppet" error.
group { "puppet": ensure => "present" }

# Determine if this box is a vagrant development VM
$vagrant_dev_vm = inline_template("<%= FileTest.exists?('/tmp/vagrant-puppet') ? 'true' : 'false' %>")

import "utils/*.pp"
import "admin"
include admin::build_dependencies

import "appuser"
include appuser

import "ruby193"
include ruby193::build

import "passenger"
include passenger::install
import "nginx"
include nginx::setup

import "mongodb"
include mongodb::install
