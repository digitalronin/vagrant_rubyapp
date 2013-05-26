import "utils/*.pp"
import "admin"
import "appuser"
import "ruby193"
import "passenger"
import "nginx"

# Fix for "Could not find group puppet" error.
group { "puppet": ensure => "present" }

# Determine if this box is a vagrant development VM
$vagrant_dev_vm = inline_template("<%= FileTest.exists?('/tmp/vagrant-puppet') ? 'true' : 'false' %>")

include appuser
include admin::build_dependencies
include ruby193::build
include passenger::install
include nginx::setup
