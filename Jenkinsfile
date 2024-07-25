pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install dependencies using npm
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                // Run tests using npm
                sh 'npm test'
            }
        }

        stage('Archive Test Results') {
            steps {
                // Archive the test results
                junit '**/test-results.xml'
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }

        success {
            // Notify success
            echo 'Build succeeded'
        }

        failure {
            // Notify failure
            echo 'Build failed'
        }
    }
}
