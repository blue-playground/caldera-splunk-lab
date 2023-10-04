
Vagrant.configure("2") do |config|

  config.vm.define "caldera" do |caldera|
    caldera.vm.box = "ubuntu/jammy64"
    caldera.vm.network "forwarded_port", guest: 8888, host: 8084,
      auto_correct:true
    caldera.vm.network "forwarded_port", guest: 8000, host: 8885,
      auto_correct:true
    caldera.vm.network "forwarded_port", guest: 8089, host: 9003,
      auto_correct:true
    caldera.vm.boot_timeout = 700
    caldera.vm.network :private_network, ip: "10.0.0.11"
    caldera.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "7000"
    end
    caldera.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update && sudo apt upgrade -y
      sudo apt install software-properties-common -y
      sudo add-apt-repository ppa:deadsnakes/ppa
      sudo apt install git -y
      sudo apt install python3.10 -y
      sudo apt-get install snapd -y
      sudo apt install python3-pip -y
      sudo snap install go --classic
      git clone https://github.com/mitre/caldera.git --recursive
    SHELL
    caldera.vm.provision "shell", run: "always" ,inline: <<-SHELL
      cd caldera
      pip3 install -r requirements.txt
      python3 server.py --insecure &
    SHELL
    caldera.vm.provision :shell, path: "scripts/nix_config/install_splunk.sh"
    end
  config.vm.define "victim" do |victim|
    victim.vm.box = "gusztavvargadr/windows-10"
    victim.vm.boot_timeout = 600
    victim.vm.communicator = "winrm"
    victim.vm.network :private_network, ip: "10.0.0.12"
    victim.winrm.port = 55985
    victim.vm.provision "shell", path: "scripts/win_config/AgentDeploy.ps1", run: "always"
    victim.vm.provision "shell", path: "scripts/win_config/install-sysmon.ps1", run: "always"

    victim.vm.provider "virtualbox" do |v|
      # v.name = "caldera_victim"
      v.gui = true
      v.memory = 4000
      v.cpus = 2
  end
end
end
