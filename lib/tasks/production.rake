#
# Build a production server from the local puppet repo
#

SSH = 'ssh -t -A -oStrictHostKeyChecking=no -l root -p 22'

namespace :deploy do
  client = ENV['CLIENT']

  task :bootstrap do
    Rake::Task["deploy:install_puppet"].invoke
    Rake::Task["deploy:copy_puppet_files"].invoke
    Rake::Task["deploy:run_puppet"].invoke
    Rake::Task["deploy:reboot"].invoke
  end

  task :reboot do
    sh "#{SSH} #{client} 'reboot'"
  end

  desc "Install Puppet on ENV['CLIENT']"
  task :install_puppet do
    commands = <<-BOOTSTRAP
    apt-get update && apt-get -y install git-core ruby facter && \
    wget http://www.puppetlabs.com/downloads/puppet/puppet-2.7.3.tar.gz && \
    tar xvf puppet-2.7.3.tar.gz && \
    cd /root/puppet-2.7.3 && ruby install.rb
    BOOTSTRAP

    sh "#{SSH} #{client} '#{commands}'"
  end

  desc "Copy local puppet tree to the target server"
  task :copy_puppet_files do
    sh "rsync -r puppet root@#{client}:/root"
  end

  desc "Apply puppet on the target server"
  task :run_puppet do
    puppet = "puppet apply --modulepath=/root/puppet/modules /root/puppet/manifests/site.pp"
    sh "#{SSH} #{client} '#{puppet}'"
  end
end
