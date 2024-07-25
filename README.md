
# CI/CD Learning Repository

Welcome to the CI/CD learning repository! This guide will walk you through the complete setup of a CI/CD pipeline using Jenkins, GitHub, Maven, SonarQube, Docker, ArgoCD, and Kubernetes. Follow each step to set up your environment and automate your software delivery process.

## Table of Contents

1. [Introduction](#introduction)
2. [Tools and Technologies](#tools-and-technologies)
3. [Setting up Git](#setting-up-git)
4. [Creating an EC2 Instance](#creating-an-ec2-instance)
5. [Setting up Jenkins](#setting-up-jenkins)
6. [Setting up SonarQube](#setting-up-sonarqube)
7. [Creating Jenkinsfile](#creating-jenkinsfile)
8. [Setting up ArgoCD](#setting-up-argocd)
9. [Author](#author)

## Introduction

Continuous Integration and Continuous Delivery (CI/CD) are crucial in modern software development, facilitating automated code integration and reliable application delivery.

Jenkins, known for its flexibility and extensive plugin options, is a leading tool for creating CI/CD pipelines.

This repository will guide you through the complete setup of a CI/CD pipeline using Jenkins, integrating it with version control systems, and orchestrating builds, tests, and deployments.

## Tools and Technologies

- GitHub for version control
- Maven for project management and builds
- SonarQube for code quality analysis
- Docker for containerization
- Jenkins for Continuous Integration
- ArgoCD and Helm for Kubernetes deployment management
- Kubernetes for orchestrating containers

## Setting up Git

### Create a Private Git Repository

1. Visit your preferred Git hosting platform (e.g., GitHub, GitLab).
2. Log in to your account or sign up if you do not have one.
3. Create a new repository and set its visibility to private.

### Generate a Personal Access Token

1. Navigate to your account settings.
2. Look for “Developer settings” or “Personal access tokens.”
3. Generate a new token with the necessary permissions (`repo`).

### Clone the Repository Locally

1. Open Git Bash or your terminal.
2. Change to the directory where you wish to clone the repository.
3. Execute the following command, replacing `<URL>` with your repository's URL:

```sh
git clone <URL>
```

## Creating an EC2 Instance

### Sign in to the AWS Management Console

1. Access the [AWS Management Console](https://aws.amazon.com/console/).
2. Log in using your AWS account credentials. If you do not have an account, create one.

### Navigate to the EC2 Dashboard

1. Find the “Services” menu at the top of the console.
2. Click on “EC2” under the “Compute” section.

### Launch Instance

1. Click on the “Launch Instances” button.
2. Add tags and names to your instance for better organization.
3. Choose an Amazon Machine Image (AMI).
4. Select the instance type (e.g., t2.micro for free tier).
5. Create a key pair for SSH access.
6. Configure security group to open ports like SSH (22), Custom TCP (8080, 9000).
7. Add storage (default size is usually fine).
8. Review and launch.

### Access Your Instance

1. Connect to your instance using SSH with the downloaded .pem file.
2. Use a tool like MobaXterm for Windows:

    - Install MobaXterm.
    - Open MobaXterm and create a new SSH session.
    - Enter the IP address, username, and select your private key.

## Setting up Jenkins

### Install Java

1. SSH into your EC2 instance.
2. Run the following commands:

```sh
sudo apt update
sudo apt install openjdk-11-jdk
java -version
```

### Install Jenkins

1. Create a script file using vim or another editor:

```sh
vim install_jenkins.sh
```

2. Add the following script:

```bash
#!/bin/bash
# Download Jenkins GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update repositories
sudo apt-get update

# Install Jenkins
sudo apt-get install jenkins -y
```

3. Make the file executable and run it:

```sh
chmod +x install_jenkins.sh
./install_jenkins.sh
```

### Adjust Firewall Settings

Ensure your security group settings allow inbound traffic on port 8080.

### Access Jenkins UI

1. Open a web browser and navigate to `http://<your_instance_ip>:8080`.
2. Unlock Jenkins using the initial admin password found at:

```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

3. Install suggested plugins.
4. Create your admin user.
5. Configure the URL and start using Jenkins.

## Setting up SonarQube

### Install Docker

1. Create a script file using vim or another editor:

```sh
vim install_docker.sh
```

2. Add the following script:

```bash
#!/bin/bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Make the file executable and run it:

```sh
chmod +x install_docker.sh
./install_docker.sh
```

### Install SonarQube

1. Pull the official SonarQube Docker image:

```sh
docker pull sonarqube
```

2. Run SonarQube in a Docker container:

```sh
docker run -d --name sonarqube -p 9000:9000 sonarqube
```

### Access SonarQube

1. Navigate to `http://<your_instance_ip>:9000`.
2. Use the default login credentials:

    - Username: admin
    - Password: admin

### Integrate with Jenkins

1. Generate a SonarQube token in your SonarQube dashboard.
2. Add the token as a credential in Jenkins.
3. Configure the Jenkins SonarQube Scanner with the server URL and token.

## Creating Jenkinsfile

A Jenkinsfile defines the stages and steps of your Jenkins pipeline. Below is an example Jenkinsfile for a Java application.

### Jenkinsfile

```groovy
pipeline {
  agent {
    docker {
      image 'abhishekf5/maven-abhishek-docker-agent:v1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  stages {
    stage('Checkout') {
      steps {
        sh 'echo passed'
        //git branch: 'main', url: 'https://github.com/wangoimwangi/jenkins-CICD.git'
      }
    }
    stage('Build and Test') {
      steps {
        sh 'ls -ltr'
        // build the project and create a JAR file
        sh 'cd spring-boot-app && mvn clean package'
      }
    }
    stage('Static Code Analysis') {
      environment {
        SONAR_URL = "http://<your_instance_ip>:9000"
      }
      steps {
        withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
          sh 'cd spring-boot-app && mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
        }
      }
    }
    stage('Build and Push Docker Image') {
      environment {
        DOCKER_IMAGE = "ultimate-cicd:${BUILD_NUMBER}"
        REGISTRY = "docker.io"
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
          sh 'cd spring-boot-app && docker build -t $REGISTRY/$DOCKER_IMAGE .'
          sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD $REGISTRY'
          sh 'docker push $REGISTRY/$DOCKER_IMAGE'
        }
      }
    }
  }
}
```

### Explanation

- **agent**: Defines the Docker image to use for running the pipeline.
- **stages**: Contains different stages such as `Checkout`, `Build and Test`, `Static Code Analysis`, and `Build and Push Docker Image`.
- **environment**: Sets environment variables like SonarQube URL and Docker image details.
- **steps**: Contains the actual commands to execute at

 each stage.

Replace placeholders like `<your_instance_ip>` with actual values as needed.

## Setting up ArgoCD

### Prerequisites

- Kubernetes cluster (can be a local cluster or on the cloud)
- `kubectl` configured to communicate with your cluster

### Install ArgoCD

1. Create a script file using vim or another editor:

```sh
vim install_argo.sh
```

2. Add the following script:

```bash
#!/bin/bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

3. Make the file executable and run it:

```sh
chmod +x install_argo.sh
./install_argo.sh
```

### Access ArgoCD

1. Forward the ArgoCD server port to access the UI:

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

2. Open a web browser and navigate to `https://localhost:8080`.

### Login to ArgoCD

1. Retrieve the initial admin password:

```sh
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d; echo
```

2. Use `admin` as the username and the retrieved password to log in.

### Integrate ArgoCD with GitHub

1. Create an application in ArgoCD to monitor your GitHub repository.
2. Use the ArgoCD UI to set up the repository URL and specify the target revision and path within the repository.
3. Define the destination cluster and namespace for deployment.

## Author

Created by [Francisco Soares](https://github.com/Jofralso). Feel free to reach out for any questions or contributions.
