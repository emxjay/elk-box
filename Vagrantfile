Vagrant.configure(2) do |config|
    config.vm.box = "debian/jessie64"

    # vagrant plugin install vagrant-proxyconf
    if Vagrant.has_plugin?("vagrant-proxyconf")
        config.proxy.http     = "<HTTP_PROXY_ADDRESS>"
        config.proxy.https    = "<HTTPS_PROXY_ADDRESS>"
        config.proxy.no_proxy = "localhost,127.0.0.1"
    end

    config.vm.network "forwarded_port", guest: 9200, host: 9200
    config.vm.network "forwarded_port", guest: 5601, host: 5601

    config.vm.network "public_network"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.customize ["modifyvm", :id, "--cpus", "4"]
    end

    config.vm.provision "shell", path: "setup.sh"

    config.vm.synced_folder ".", "/home/vagrant/elk_box", type: "virtualbox"
end
