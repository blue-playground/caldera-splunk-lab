
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 8888, host: 8082,
    auto_correct:true
  config.vm.boot_timeout = 600
  
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "9000"
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt upgrade -y
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install git -y
    sudo apt install python3.10 -y
    sudo apt-get install snapd -y
    sudo apt install python3-pip -y
    sudo snap install go --classic
    git clone https://github.com/mitre/caldera.git --recursive
    cd caldera
    pip3 install -r requirements.txt
    python3 server.py --insecure
  SHELL
end
