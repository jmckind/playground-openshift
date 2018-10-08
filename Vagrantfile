$openshift_version = "release-3.11"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false # always use Vagrant's insecure key

  config.vm.box = "centos/7"
  config.vm.hostname = "playground-openshift"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vbx|
    vbx.name = "playground-openshift-%s" % $openshift_version
    vbx.memory = 4096
    vbx.cpus = 4
  end

  config.vm.provision "shell" do |s|
    s.path = "provision.sh"
    s.env  = {OPENSHIFT_VERSION: $openshift_version}
  end
end
