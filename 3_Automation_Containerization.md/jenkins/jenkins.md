 Jenkins

## Overview

Jenkins is an open-source automation server used for building, testing, and deploying applications. It supports continuous integration and continuous delivery, making it a crucial tool in DevOps pipelines.

## Key Concepts

- **Jobs**: Basic building blocks of Jenkins, representing a task or step in the build process.
- **Pipelines**: Define the series of steps to be executed, allowing complex build workflows to be automated.
- **Plugins**: Extend Jenkins functionality, integrating with various tools and platforms.
- **Nodes and Executors**: Jenkins can distribute build processes across multiple nodes to improve performance and scalability.

## Resources

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Jenkins Pipeline Tutorial](https://www.jenkins.io/doc/pipeline/tour/getting-started/)

## Practice Problems

### Easy Problem

**Task**: Create a Jenkins job to build a simple "Hello, World!" project.

1. Set up a new Freestyle project.
2. Add a build step to execute a shell command: `echo "Hello, World!"`.

### Medium Problem

**Task**: Create a Jenkins pipeline to build and test a Node.js project.

1. Set up a new Pipeline project.
2. Define a Jenkinsfile with stages for installing dependencies, running tests, and building the project.

### Hard Problem

**Task**: Create a Jenkins pipeline for a multi-branch project with different stages for development and production.

1. Set up a new Multi-branch Pipeline project.
2. Define a Jenkinsfile with conditional stages based on the branch name.
3. Integrate a deployment step for the production branch.

## Solutions

### Easy Problem Solution

**Steps**:
1. Create a new Freestyle project.
2. In the build step, select "Execute shell" and enter `echo "Hello, World!"`.

### Medium Problem Solution

**Jenkinsfile**:
```groovy
pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
}
```

### Hard Problem Solution

**Jenkinsfile**:
```groovy
pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                // Deployment steps
            }
        }
    }
}