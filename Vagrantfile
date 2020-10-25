Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.box = "centos/8"
  config.vm.box_version = "1905.1"

  config.vagrant.plugins = "vagrant-docker-compose"

  # Install Docker
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/elk.yml", run: "always", options: "--project-name schemacrawler-elk"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.network :forwarded_port, guest: 9000, host: 9090
  config.vm.network :forwarded_port, guest: 5601, host: 5601
  config.vm.network :forwarded_port, guest: 9200, host: 9200


end