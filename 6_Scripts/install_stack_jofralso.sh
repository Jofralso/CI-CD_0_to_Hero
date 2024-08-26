#!/bin/bash

# Function for menu
function menu() {
    echo "1. Install all"
    echo "2. Install single tool"
    echo "3. Uninstall all"
    echo "4. Uninstall single tool"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            sudo rm /etc/apt/sources.list.d/grafana.list
            echo "Installing all tools..."
            install_git
            install_ansible
            install_docker
            install_grafana
            install_jenkins
            install_prometheus
            install_zuul
            install_kubernetes
            install_maven
            ;;
        2)
            echo "Installing single tool..."
            echo "1. CI Tools"
            echo "2. CD Tools"
            read -p "Enter your choice: " ci_cd_choice
            case $ci_cd_choice in
                1)
                    echo "1. Git"
                    echo "2. Ansible"
                    echo "3. Prometheus"
                    echo "4. Zuul"
                    read -p "Enter your choice: " ci_choice
                    case $ci_choice in
                        1)
                            install_git
                            ;;#!/bin/bash

# Function for menu
function menu() {
    echo "1. Install all"
    echo "2. Install single tool"
    echo "3. Uninstall all"
    echo "4. Uninstall single tool"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            sudo rm /etc/apt/sources.list.d/grafana.list
            echo "Installing all tools..."
            install_git
            install_ansible
            install_docker
            install_grafana
            install_jenkins
            install_prometheus
            install_zuul
            install_kubernetes
            install_maven
            ;;
        2)
            echo "Installing single tool..."
            echo "1. CI Tools"
            echo "2. CD Tools"
            read -p "Enter your choice: " ci_cd_choice
            case $ci_cd_choice in
                1)
                    echo "1. Git"
                    echo "2. Ansible"
                    echo "3. Prometheus"
                    echo "4. Zuul"
                    read -p "Enter your choice: " ci_choice
                    case $ci_choice in
                        1)
                            install_git
                            ;;
                        2)
                            install_ansible
                            ;;
                        3)
                            install_prometheus
                            ;;
                        4)
                            install_zuul
                            ;;
                        *)
                            echo "Invalid choice"
                            ;;
                    esac
                    ;;
                2)
                    echo "1. Jenkins"
                    echo "2. Grafana"
                    echo "3. Docker"
                    echo "4. Kubernetes"
                    read -p "Enter your choice: " cd_choice
                    case $cd_choice in
                        1)
                            install_jenkins
                            ;;
                        2)
                            install_grafana
                            ;;
                        3)
                            install_docker
                            ;;
                        4)
                            install_kubernetes
                            ;;
                        *)
                            echo "Invalid choice"
                            ;;
                    esac
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        3)
            echo "Uninstalling all tools..."
            uninstall_git
            uninstall_ansible
            uninstall_docker
            uninstall_grafana
            uninstall_jenkins
            uninstall_prometheus
            uninstall_zuul
            uninstall_kubernetes
            uninstall_maven
            ;;
        4)
            echo "Uninstalling single tool..."
            echo "1. Git"
            echo "2. Ansible"
            echo "3. Prometheus"
            echo "4. Zuul"
            echo "5. Jenkins"
            echo "6. Grafana"
            echo "7. Docker"
            echo "8. Kubernetes"
            echo "9. Maven"
            read -p "Enter your choice: " uninstall_choice
            case $uninstall_choice in
                1)
                    uninstall_git
                    ;;
                2)
                    uninstall_ansible
                    ;;
                3)
                    uninstall_prometheus
                    ;;
                4)
                    uninstall_zuul
                    ;;
                5)
                    uninstall_jenkins
                    ;;
                6)
                    uninstall_grafana
                    ;;
                7)
                    uninstall_docker
                    ;;
                8)
                    uninstall_kubernetes
                    ;;
                9)
                    uninstall_maven
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

# Functions for installing tools
function install_git() {
    echo "Git installation..."
    # Install Git
    sudo apt install git-all
}


function install_ansible() {
    echo "Ansible installation..."
    # Install Ansible
    pipx install --include-deps ansible
}

function install_docker() {
    echo "Docker installation..."
    # Install Docker
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function install_grafana() {
    echo "Grafana installation..."
    # Install Grafana
    # Install the prerequisite packages:
    sudo apt-get install -y apt-transport-https software-properties-common wget

    # Import the GPG key:
    sudo mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

    # To add a repository for stable releases, run the following command:
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

    # Run the following command to update the list of available packages:
    sudo apt-get update

    # Installs the latest OSS release:
    sudo apt-get install grafana
}

function install_jenkins() {
    echo "Jenkins installation..."
    # Install Jenkins
    sudo apt update
    sudo apt install fontconfig openjdk-17-jre
    java -version

    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins
}

function install_prometheus() {
    echo "Prometheus installation..."
    # Install Prometheus
     wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
     tar xvfz prometheus-2.43.0.linux-amd64.tar.gz
     cd prometheus-2.43.0.linux-amd64
     sudo cp prometheus /usr/local/bin/
     sudo cp promtool /usr/local/bin/
     sudo mkdir /etc/prometheus
     sudo cp prometheus.yml /etc/prometheus/
}

function install_zuul() {
    echo "Zuul installation..."
    # Install Zuul
    sudo apt-get update
    sudo apt-get install podman git python3-pip
    sudo python3 -m pip install git-review podman-compose
    git clone https://opendev.org/zuul/zuul
}

function install_kubernetes() {
    echo "Kubernetes installation..."
    # Install Kubernetes
    sudo apt update
    sudo apt install snapd
    sudo snap install microk8s --classic
    Kubernetes starts

    microk8s status --wait-ready


    microk8s enable dashboard

    microk8s enable dns

    microk8s enable registry

    microk8s enable istio
    microk8s kubectl get all --all-namespaces
    microk8s dashboard-proxy
    microk8s start




}

function install_maven() {
    echo "Maven installation..."
    # Install Maven
    wget https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
    tar -xvf openjdk-13.0.1_linux-x64_bin.tar.gz
    mv jdk-13.0.1 /opt/


    echo "JAVA_HOME='/opt/jdk-13.0.1'" >> ~/.profile
    echo "PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> ~/.profile
    echo "export PATH" >> ~/.profile
    source ~/.profile


    java -version

    wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    ar -xvf apache-maven-3.6.3-bin.tar.gz
    mv apache-maven-3.6.3 /opt/\

    
    echo "M2_HOME='/opt/apache-maven-3.6.3'" >> ~/.profile
    echo "PATH=\"\$M2_HOME/bin:\$PATH\"" >> ~/.profile
    echo "export PATH" >> ~/.profile
    source ~/.profile

    mvn -version
}

# Functions for uninstalling tools
function uninstall_git() {
    echo "Uninstalling Git..."
    # Uninstall Git
    sudo apt remove git-all

    sudo apt autoremove

    sudo apt update


}

function uninstall_ansible() {
    echo "Uninstalling Ansible..."
    # Uninstall Ansible
    pipx uninstall ansible

}

function uninstall_docker() {
    echo "Uninstalling Docker..."
    # Uninstall Docker
    sudo apt-get remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo apt autoremove

    sudo apt update


}

function uninstall_grafana() {
    echo "Uninstalling Grafana..."
    # Uninstall Grafana
    sudo systemctl stop grafana-server
    sudo service grafana-server stop
    sudo apt-get remove grafana
}

function uninstall_jenkins() {
    echo "Uninstalling Jenkins..."
    # Uninstall Jenkins
    sudo apt-get remove jenkins

    sudo apt autoremove
}

function uninstall_prometheus() {
    echo "Uninstalling Prometheus..."
    # Uninstall Prometheus
    sudo systemctl stop prometheus

    sudo apt-get remove prometheus

    sudo apt autoremove


}

function uninstall_zuul() {
    echo "Uninstalling Zuul..."
    # Uninstall Zuul

    sudo apt-get remove zuul

    sudo apt autoremove
}

function uninstall_kubernetes() {
    echo "Uninstalling Kubernetes..."
    # Uninstall Kubernetes

    microk8s stop

    microk8s remove

    sudo apt autoremove

    sudo apt update
}

function uninstall_maven() {
    echo "Uninstalling Maven..."
    # Uninstall Maven

    sudo apt-get remove maven

    sudo apt autoremove

    sudo apt update

}

# Main menu
while true; do
    menu
    read -p "Do you want to continue? (Y/N): " choice
    if [[ $choice =~ ^[Nn]$ ]]; then
        break
    fi
done

                        2)
                            install_ansible
                            ;;
                        3)
                            install_prometheus
                            ;;
                        4)
                            install_zuul
                            ;;
                        *)
                            echo "Invalid choice"
                            ;;
                    esac
                    ;;
                2)
                    echo "1. Jenkins"
                    echo "2. Grafana"
                    echo "3. Docker"
                    echo "4. Kubernetes"
                    read -p "Enter your choice: " cd_choice
                    case $cd_choice in
                        1)
                            install_jenkins
                            ;;
                        2)
                            install_grafana
                            ;;
                        3)
                            install_docker
                            ;;
                        4)
                            install_kubernetes
                            ;;
                        *)
                            echo "Invalid choice"
                            ;;
                    esac
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        3)
            echo "Uninstalling all tools..."
            uninstall_git
            uninstall_ansible
            uninstall_docker
            uninstall_grafana
            uninstall_jenkins
            uninstall_prometheus
            uninstall_zuul
            uninstall_kubernetes
            uninstall_maven
            ;;
        4)
            echo "Uninstalling single tool..."
            echo "1. Git"
            echo "2. Ansible"
            echo "3. Prometheus"
            echo "4. Zuul"
            echo "5. Jenkins"
            echo "6. Grafana"
            echo "7. Docker"
            echo "8. Kubernetes"
            echo "9. Maven"
            read -p "Enter your choice: " uninstall_choice
            case $uninstall_choice in
                1)
                    uninstall_git
                    ;;
                2)
                    uninstall_ansible
                    ;;
                3)
                    uninstall_prometheus
                    ;;
                4)
                    uninstall_zuul
                    ;;
                5)
                    uninstall_jenkins
                    ;;
                6)
                    uninstall_grafana
                    ;;
                7)
                    uninstall_docker
                    ;;
                8)
                    uninstall_kubernetes
                    ;;
                9)
                    uninstall_maven
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

# Functions for installing tools
function install_git() {
    echo "Git installation..."
    # Install Git
    sudo apt install git-all
}


function install_ansible() {
    echo "Ansible installation..."
    # Install Ansible
    pipx install --include-deps ansible
}

function install_docker() {
    echo "Docker installation..."
    # Install Docker
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function install_grafana() {
    echo "Grafana installation..."
    # Install Grafana
    # Install the prerequisite packages:
    sudo apt-get install -y apt-transport-https software-properties-common wget

    # Import the GPG key:
    sudo mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

    # To add a repository for stable releases, run the following command:
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

    # Run the following command to update the list of available packages:
    sudo apt-get update

    # Installs the latest OSS release:
    sudo apt-get install grafana
}

function install_jenkins() {
    echo "Jenkins installation..."
    # Install Jenkins
    sudo apt update
    sudo apt install fontconfig openjdk-17-jre
    java -version

    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins
}

function install_prometheus() {
    echo "Prometheus installation..."
    # Install Prometheus
     wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
     tar xvfz prometheus-2.43.0.linux-amd64.tar.gz
     cd prometheus-2.43.0.linux-amd64
     sudo cp prometheus /usr/local/bin/
     sudo cp promtool /usr/local/bin/
     sudo mkdir /etc/prometheus
     sudo cp prometheus.yml /etc/prometheus/
}

function install_zuul() {
    echo "Zuul installation..."
    # Install Zuul
    sudo apt-get update
    sudo apt-get install podman git python3-pip
    sudo python3 -m pip install git-review podman-compose
    git clone https://opendev.org/zuul/zuul
}

function install_kubernetes() {
    echo "Kubernetes installation..."
    # Install Kubernetes
    sudo apt update
    sudo apt install snapd
    sudo snap install microk8s --classic

    sudo microk8s status --wait-ready


    sudo microk8s enable dashboard

    sudo microk8s enable dns

    sudo microk8s enable registry

    sudo microk8s enable istio
    sudo microk8s kubectl get all --all-namespaces
    sudo microk8s dashboard-proxy
    sudo microk8s start




}

function install_maven() {
    echo "Maven installation..."
    # Install Maven
    wget https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
    tar -xvf openjdk-13.0.1_linux-x64_bin.tar.gz
    sudo mv jdk-13.0.1 /opt/


    echo "JAVA_HOME='/opt/jdk-13.0.1'" >> ~/.profile
    echo "PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> ~/.profile
    echo "export PATH" >> ~/.profile
    source ~/.profile


    java -version

    wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
    tar -xvf apache-maven-3.6.3-bin.tar.gz
    sudo mv apache-maven-3.6.3 /opt/

    
    echo "M2_HOME='/opt/apache-maven-3.6.3'" >> ~/.profile
    echo "PATH=\"\$M2_HOME/bin:\$PATH\"" >> ~/.profile
    echo "export PATH" >> ~/.profile
    source ~/.profile

    mvn -version
}

# Functions for uninstalling tools
function uninstall_git() {
    echo "Uninstalling Git..."
    # Uninstall Git
    sudo apt remove git-all

    sudo apt autoremove

    sudo apt update


}

function uninstall_ansible() {
    echo "Uninstalling Ansible..."
    # Uninstall Ansible
    pipx uninstall ansible

}

function uninstall_docker() {
    echo "Uninstalling Docker..."
    # Uninstall Docker
    sudo apt-get remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo apt autoremove

    sudo apt update


}

function uninstall_grafana() {
    echo "Uninstalling Grafana..."
    # Uninstall Grafana
    sudo systemctl stop grafana-server
    sudo service grafana-server stop
    sudo apt-get remove grafana
}

function uninstall_jenkins() {
    echo "Uninstalling Jenkins..."
    # Uninstall Jenkins
    sudo apt-get remove jenkins

    sudo apt autoremove
}

function uninstall_prometheus() {
    echo "Uninstalling Prometheus..."
    # Uninstall Prometheus
    sudo systemctl stop prometheus

    sudo apt-get remove prometheus

    sudo apt autoremove


}

function uninstall_zuul() {
    echo "Uninstalling Zuul..."
    # Uninstall Zuul

    sudo apt-get remove zuul

    sudo apt autoremove
}

function uninstall_kubernetes() {
    echo "Uninstalling Kubernetes..."
    # Uninstall Kubernetes

    microk8s stop

    microk8s remove

    sudo apt autoremove

    sudo apt update
}

function uninstall_maven() {
    echo "Uninstalling Maven..."
    # Uninstall Maven

    sudo apt-get remove maven

    sudo apt autoremove

    sudo apt update

}

# Main menu
while true; do
    menu
    read -p "Do you want to continue? (Y/N): " choice
    if [[ $choice =~ ^[Nn]$ ]]; then
        break
    fi
done
