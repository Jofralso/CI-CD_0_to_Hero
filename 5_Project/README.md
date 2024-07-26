# CI/CD Pipeline Setup Guide: Real-Life Example

This guide provides a detailed setup for creating a CI/CD pipeline using Ansible, Docker, GitHub, Grafana, Jenkins, Prometheus, and Zuul. We will use a sample Python web application to test the entire pipeline.

## Real-Life Example: Web Application Deployment

In this example, we'll deploy a simple Flask application. The pipeline will build, test, and deploy the application automatically.

### 1. Prerequisites

Ensure that you have the following tools installed and configured:

- **Docker**: Containerization platform.
- **Jenkins**: Automation server for CI/CD.
- **Prometheus**: Monitoring and alerting toolkit.
- **Grafana**: Visualization and analytics platform.
- **Zuul**: CI/CD orchestration tool.
- **Ansible**: Configuration management and automation tool.
- **GitHub**: Version control system.

### 2. Install and Configure Tools

#### 2.1. Docker Installation

1. **Download Docker**:
   - Visit [Docker's official installation page](https://docs.docker.com/get-docker/).

2. **Install Docker**:
   - **On Ubuntu**:
     ```bash
     sudo apt-get update
     sudo apt-get install docker-ce docker-ce-cli containerd.io
     ```
   - **On Windows** and **MacOS**:
     - Download Docker Desktop from the [Docker website](https://www.docker.com/products/docker-desktop) and follow the installation instructions.

3. **Verify Installation**:
   ```bash
   docker --version
   ```

#### 2.2. Jenkins Installation

1. **Download Jenkins**:
   - Visit [Jenkins' official download page](https://www.jenkins.io/download/).

2. **Install Jenkins**:
   - **On Ubuntu**:
     ```bash
     sudo apt update
     sudo apt install openjdk-11-jdk
     wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
     sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary > /etc/apt/sources.list.d/jenkins.list'
     sudo apt update
     sudo apt install jenkins
     ```
   - **On Windows**:
     - Download and run the Jenkins installer from the [Jenkins website](https://www.jenkins.io/download/).

3. **Start Jenkins**:
   ```bash
   sudo systemctl start jenkins
   ```

4. **Access Jenkins**:
   - Open [http://localhost:8080](http://localhost:8080) in your browser.

5. **Install Plugins**:
   - Go to **Manage Jenkins** -> **Manage Plugins**.
   - Install the following plugins: Docker Pipeline, Ansible, GitHub Integration, Prometheus Monitoring.

#### 2.3. Prometheus Installation

1. **Download Prometheus**:
   - Visit [Prometheus' official download page](https://prometheus.io/download/).

2. **Install Prometheus**:
   - **On Linux**:
     ```bash
     wget https://github.com/prometheus/prometheus/releases/download/v2.36.0/prometheus-2.36.0.linux-amd64.tar.gz
     tar xvf prometheus-2.36.0.linux-amd64.tar.gz
     cd prometheus-2.36.0.linux-amd64
     ```
   - **On Windows**:
     - Download and extract the Prometheus binary from the [Prometheus website](https://prometheus.io/download/).

3. **Configure Prometheus**:
   - Create a `prometheus.yml` file with the following content:

     ```yaml
     scrape_configs:
       - job_name: 'jenkins'
         static_configs:
           - targets: ['localhost:8080']
     ```

4. **Start Prometheus**:
   ```bash
   ./prometheus --config.file=prometheus.yml
   ```

5. **Access Prometheus**:
   - Open [http://localhost:9090](http://localhost:9090) in your browser.

#### 2.4. Grafana Installation

1. **Download Grafana**:
   - Visit [Grafana's official download page](https://grafana.com/grafana/download).

2. **Install Grafana**:
   - **On Ubuntu**:
     ```bash
     sudo apt-get install -y apt-transport-https software-properties-common wget
     sudo mkdir -p /etc/apt/keyrings/
     wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
     echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
     # Updates the list of available packages
     sudo apt-get update
     # Installs the latest OSS release:
     sudo apt-get install grafana
     ```
   - **On Windows**:
     - Download and run the Grafana installer from the [Grafana website](https://grafana.com/grafana/download).

3. **Start Grafana**:
   ```bash
   sudo systemctl start grafana-server
   ```

4. **Access Grafana**:
   - Open [http://localhost:3000](http://localhost:3000) in your browser.
   - Default login: `admin` / `admin`.

5. **Add Prometheus Data Source**:
   - Go to **Configuration** -> **Data Sources** -> **Add data source**.
   - Select **Prometheus** and set the URL to `http://localhost:9090`.

#### 2.5. Zuul Installation

1. **Install Zuul**:
   - Follow the [Zuul installation guide](https://zuul-ci.org/docs/zuul/latest/) to set up Zuul on your system.

2. **Configure Zuul**:
   - Create a `zuul.yaml` file in your Zuul configuration directory:

     ```yaml
     - pipeline:
         name: ci-cd-pipeline
         triggers:
           - github:
               repository: your-repo/ci-cd-example
         jobs:
           - job: build-and-deploy
             run: playbooks/build-and-deploy.yml
     ```

3. **Start Zuul**:
   - Follow the [Zuul documentation](https://zuul-ci.org/docs/zuul/latest/) for specific commands to start Zuul.

#### 2.6. Ansible Installation

1. **Install Ansible**:
   - **On Ubuntu**:
     ```bash
     sudo apt update
     sudo apt install ansible
     ```
   - **On Windows**:
     - Use WSL (Windows Subsystem for Linux) to install Ansible.

2. **Verify Installation**:
   ```bash
   ansible --version
   ```

### 3. Example Application

1. **Create a GitHub Repository**

   - Go to [GitHub](https://github.com/) and create a new repository named `ci-cd-example`.
   - Clone the repository to your local machine:

     ```bash
     git clone https://github.com/your-repo/ci-cd-example.git
     cd ci-cd-example
     ```

2. **Add Application Code**

   Create the following files in the repository:

   - **`app.py`**: A simple Flask application.

     ```python
     from flask import Flask

     app = Flask(__name__)

     @app.route('/')
     def home():
         return "Hello, World!"

     if __name__ == "__main__":
         app.run(debug=True, host='0.0.0.0')
     ```

   - **`requirements.txt`**: Required Python packages.

     ```
     Flask==2.0.1
     ```

   - **`Dockerfile`**: Dockerfile to containerize the application.

     ```dockerfile
     FROM python:3.8-slim
     WORKDIR /app
     COPY . /app
     RUN pip install -r requirements.txt
     CMD ["python", "app.py"]
     ```

   - **`deploy.yml`**: Ansible playbook for deployment.

     ```yaml
     - hosts: all
       tasks:
         - name: Deploy web application
           docker_container:
             name: webapp
             image: ci-cd-example:latest
             state: started
             restart_policy: always
     ```

   - **`inventory.ini`**: Inventory file for Ansible.

     ```ini
     [servers]
     localhost ansible_connection=local
     ```

   - **`.zuul.yaml`**: Zuul configuration for the CI/CD pipeline.

     ```yaml
     - pipeline:
         name: ci-cd-pipeline
         triggers:
           - github:
               repository: your-repo/ci-cd-example
         jobs:
           - job: build-and-deploy
             run: playbooks/build-and-deploy.yml
     ```

3. **Push the Code to GitHub**

   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### 4. Jenkins Configuration

1. **Create Jenkins Pipeline**

   - Go to **New Item** -> **Pipeline**.
   - Name the job `ci-cd-pipeline` and click **OK**.
   - Under **Pipeline**, use the following `Jenkinsfile`:

     ```groovy
     pipeline {
         agent any
         stages {
             stage('Checkout') {
                 steps {
                     git 'https://github.com/your-repo/ci-cd-example.git'
                 }
             }
             stage('Build Docker Image') {
                 steps {
                     script {
                         docker.build('ci-cd-example')
                     }
                 }
             }
             stage('Run Tests') {
                 steps {
                     sh 'docker run --rm ci-cd-example pytest'
                

 }
             }
             stage('Deploy') {
                 steps {
                     ansiblePlaybook(
                         playbook: 'deploy.yml',
                         inventory: 'inventory.ini'
                     )
                 }
             }
         }
     }
     ```

2. **Configure GitHub Webhook**

   - Go to your GitHub repository settings.
   - Navigate to **Webhooks** -> **Add webhook**.
   - Set the payload URL to your Jenkins server’s webhook endpoint (e.g., `http://your-jenkins-url/github-webhook/`).
   - Set the content type to `application/json`.
   - Choose to trigger on **Just the push event**.
   - Click **Add webhook**.

### 5. Prometheus and Grafana Setup

1. **Configure Prometheus**

   - Create a `prometheus.yml` configuration file for Prometheus to scrape Jenkins metrics.

     ```yaml
     scrape_configs:
       - job_name: 'jenkins'
         static_configs:
           - targets: ['localhost:8080']
     ```

   - Start Prometheus with the configuration file:

     ```bash
     ./prometheus --config.file=prometheus.yml
     ```

2. **Configure Grafana**

   - Go to [Grafana](http://localhost:3000/) and log in.
   - Add Prometheus as a data source:
     - Go to **Configuration** -> **Data Sources** -> **Add data source**.
     - Select **Prometheus** and set the URL to `http://localhost:9090`.
   - Create a dashboard:
     - Go to **Dashboards** -> **New Dashboard**.
     - Add panels to visualize Jenkins metrics such as build duration and error rates.

### 6. Zuul Configuration

1. **Create Zuul Configuration**

   - Create a file named `zuul.yaml` with the following content:

     ```yaml
     - pipeline:
         name: ci-cd-pipeline
         triggers:
           - github:
               repository: your-repo/ci-cd-example
         jobs:
           - job: build-and-deploy
             run: playbooks/build-and-deploy.yml
     ```

2. **Run Zuul**

   - Start Zuul by following the [Zuul documentation](https://zuul-ci.org/docs/zuul/latest/).

### 7. Testing the Pipeline

1. **Commit Code Changes**

   - Make a change to the `app.py` file or add a new feature.
   - Push the changes to GitHub:

     ```bash
     git add .
     git commit -m "Update application"
     git push origin main
     ```

2. **Verify Jenkins Build**

   - Check Jenkins to ensure that the build pipeline runs automatically and completes successfully.
   - Review logs and verify that Docker images are built and deployed using Ansible.

3. **Check Prometheus and Grafana**

   - Verify that Prometheus is scraping metrics from Jenkins.
   - Check Grafana dashboards to ensure metrics are displayed correctly.

4. **Verify Application Deployment**

   - Access the application through its public URL or IP address to confirm that it is running with the new changes.

## Conclusion

You've successfully set up a complete CI/CD pipeline using Ansible, Docker, GitHub, Grafana, Jenkins, Prometheus, and Zuul. This example demonstrates how these tools work together to automate the process of building, testing, and deploying an application.

For further customization and advanced features, consult the official documentation for each tool:
- [Ansible Documentation](https://docs.ansible.com/)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub Documentation](https://docs.github.com/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Zuul Documentation](https://zuul-ci.org/docs/zuul/latest/)
