# Automation and Containerization Tools - Jenkins

## Overview

Jenkins is an open-source automation server designed to help automate various aspects of software development, including building, testing, and deploying code. It is widely used for continuous integration (CI) and continuous delivery (CD) processes, allowing teams to deliver software faster and more reliably.

## Detailed Explanation

### Basic Concepts

- **Pipelines**: Pipelines define a series of stages and steps that describe the workflow of a CI/CD process. Jenkins supports both declarative and scripted pipeline syntax.

- **Jobs**: Individual tasks or operations that Jenkins performs. Jobs can be simple tasks, such as running a script, or complex workflows.

- **Builds**: The process of compiling and assembling code. Builds can be triggered manually, on a schedule, or automatically when changes are detected in the source code.

- **Plugins**: Jenkins supports plugins that extend its functionality. There are plugins for integrating with version control systems, build tools, notification systems, and more.

- **Nodes**: Jenkins operates with a master-slave architecture. The master node manages the Jenkins environment, while slave nodes execute builds and tasks.

### Advanced Concepts

- **Declarative Pipelines**: A more structured and readable way to define pipelines using a domain-specific language (DSL). Example:
  ```groovy
  pipeline {
    agent any
    stages {
      stage('Build') {
        steps {
          echo 'Building...'
        }
      }
      stage('Test') {
        steps {
          echo 'Testing...'
        }
      }
      stage('Deploy') {
        steps {
          echo 'Deploying...'
        }
      }
    }
  }
  ```

- **Scripted Pipelines**: More flexible and allows for complex scripting. Example:
  ```groovy
  node {
    stage('Build') {
      echo 'Building...'
    }
    stage('Test') {
      echo 'Testing...'
    }
    stage('Deploy') {
      echo 'Deploying...'
    }
  }
  ```

- **Blue Ocean**: A modern user interface for Jenkins that provides a more intuitive way to create and visualize pipelines.

- **Jenkinsfile**: A file that contains the pipeline definition for Jenkins. It is typically stored in the root directory of the repository.

## Setup and Installation

### Installing Jenkins

1. **On Linux**:
   - **Add Repository and Install**:
     ```bash
     wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
     sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary > /etc/apt/sources.list.d/jenkins.list'
     sudo apt-get update
     sudo apt-get install jenkins
     ```

   - **Start Jenkins**:
     ```bash
     sudo systemctl start jenkins
     sudo systemctl enable jenkins
     ```

2. **On macOS**:
   - **Install with Homebrew**:
     ```bash
     brew install jenkins-lts
     ```

   - **Start Jenkins**:
     ```bash
     brew services start jenkins-lts
     ```

3. **On Windows**:
   - **Download the Installer** from the [Jenkins website](https://www.jenkins.io/download/).
   - **Run the Installer** and follow the setup prompts.

4. **Access Jenkins**:
   - Open your web browser and go to `http://localhost:8080`. Follow the instructions to unlock Jenkins using the initial admin password located in the log file.

### Basic Commands

- **Start Jenkins Server**:
  ```bash
  sudo systemctl start jenkins
  ```

- **Stop Jenkins Server**:
  ```bash
  sudo systemctl stop jenkins
  ```

- **Restart Jenkins Server**:
  ```bash
  sudo systemctl restart jenkins
  ```

- **Check Jenkins Status**:
  ```bash
  sudo systemctl status jenkins
  ```

## Resources

- [Jenkins Official Documentation](https://www.jenkins.io/doc/)
- [Jenkins GitHub Repository](https://github.com/jenkinsci/jenkins)
- [Jenkins Plugins](https://plugins.jenkins.io/)

## Exercises

### Easy Problem

**Task**: Install Jenkins and create a simple Freestyle project that prints "Hello, Jenkins!" to the console.

**Solution**:

1. **Install Jenkins** using the instructions above for your operating system.
2. **Access Jenkins** at `http://localhost:8080`.
3. **Create a New Job**:
   - Click on "New Item" and select "Freestyle project".
   - Enter a name for the project and click "OK".
4. **Configure Build Step**:
   - Under "Build", click "Add build step" and select "Execute shell" (or "Execute Windows batch command" for Windows).
   - Enter the following command:
     ```bash
     echo "Hello, Jenkins!"
     ```
5. **Build Project**:
   - Click "Build Now" to run the job. Check the console output to see "Hello, Jenkins!" printed.

### Medium Problem

**Task**: Create a Jenkins pipeline using the Declarative Pipeline syntax that builds, tests, and deploys a simple application.

**Solution**:

1. **Create a New Pipeline Job**:
   - Click on "New Item" and select "Pipeline".
   - Enter a name for the pipeline and click "OK".
   
2. **Define Pipeline in Jenkinsfile**:
   - In the pipeline configuration, select "Pipeline script" and enter the following code:
     ```groovy
     pipeline {
       agent any
       stages {
         stage('Build') {
           steps {
             echo 'Building...'
             // Add build steps here
           }
         }
         stage('Test') {
           steps {
             echo 'Testing...'
             // Add test steps here
           }
         }
         stage('Deploy') {
           steps {
             echo 'Deploying...'
             // Add deploy steps here
           }
         }
       }
     }
     ```
3. **Run Pipeline**:
   - Click "Build Now" to execute the pipeline. Monitor the stages and steps in the build history.

### Hard Problem

**Task**: Configure Jenkins to use Docker for building and running tests in a containerized environment. Create a Jenkins pipeline that builds a Docker image, runs tests inside the container, and then pushes the image to Docker Hub.

**Solution**:

1. **Install Docker**:
   - Follow Docker installation instructions for your operating system.

2. **Install Docker Plugin for Jenkins**:
   - Go to "Manage Jenkins" -> "Manage Plugins" -> "Available".
   - Search for "Docker" and install the Docker plugin.

3. **Create a Dockerfile** in your project repository:
   ```Dockerfile
   FROM python:3.8-slim
   WORKDIR /app
   COPY . /app
   RUN pip install -r requirements.txt
   CMD ["pytest"]
   ```

4. **Define Jenkins Pipeline**:
   - Create a new Pipeline job and use the following script:
     ```groovy
     pipeline {
       agent any
       environment {
         DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
         DOCKER_IMAGE = 'myusername/myapp'
       }
       stages {
         stage('Build Docker Image') {
           steps {
             script {
               docker.build(DOCKER_IMAGE)
             }
           }
         }
         stage('Run Tests') {
           steps {
             script {
               docker.image(DOCKER_IMAGE).inside {
                 sh 'pytest'
               }
             }
           }
         }
         stage('Push Docker Image') {
           steps {
             script {
               docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                 docker.image(DOCKER_IMAGE).push('latest')
               }
             }
           }
         }
       }
     }
     ```
   - Replace `DOCKER_CREDENTIALS_ID` with the ID of your Docker Hub credentials in Jenkins.

5. **Run Pipeline**:
   - Click "Build Now" to execute the pipeline. Verify that the Docker image is built, tests are run, and the image is pushed to Docker Hub.

## Cheat Sheet

### Basic Jenkins Commands

- **Start Jenkins**:
  ```bash
  sudo systemctl start jenkins
  ```

- **Stop Jenkins**:
  ```bash
  sudo systemctl stop jenkins
  ```

- **Restart Jenkins**:
  ```bash
  sudo systemctl restart jenkins
  ```

- **Check Status**:
  ```bash
  sudo systemctl status jenkins
  ```

### Pipeline Syntax

- **Declarative Pipeline**:
  ```groovy
  pipeline {
    agent any
    stages {
      stage('Stage Name') {
        steps {
          // Commands here
        }
      }
    }
  }
  ```

- **Scripted Pipeline**:
  ```groovy
  node {
    stage('Stage Name') {
      // Commands here
    }
  }
  ```

### Docker Integration

- **Build Docker Image**:
  ```groovy
  docker.build('my-image')
  ```

- **Run Commands Inside Container**:
  ```groovy
  docker.image('my-image').inside {
    sh 'command'
  }
  ```

- **Push Docker Image**:
  ```groovy
  docker.withRegistry('https://index.docker.io/v1/', 'credentials-id') {
    docker.image('my-image').push('latest')
  }
  ```
