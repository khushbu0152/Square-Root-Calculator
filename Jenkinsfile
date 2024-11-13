pipeline {
    agent any
    environment {
        // Define image name and port as variables
        IMAGE_NAME = "myapp:test"
        CONTAINER_NAME = "myapp-container"
        PORT = "8080:8080"
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Pull code from GitHub
                git url: 'https://github.com/khushbu0152/Square-Root-Calculator.git', branch: 'main'
            }
        }
        
        stage('Run Unit Tests') {
            steps {
                script {
                    try {
                        // Run tests with pytest (or replace with appropriate command)
                        sh 'pytest --junitxml=test_results.xml'
                    } catch (Exception e) {
                        // Fail the build if tests fail
                        error("Unit tests failed")
                    }
                }
            }
        }
        
        stage('Publish Test Results') {
            steps {
                // Publish test results in Jenkins
                junit 'test_results.xml'
            }
        }

        stage('Build Docker Image') {
            when {
                // Only run this stage if tests pass
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Build Docker image
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }
        
        stage('Deploy to Docker Container') {
            when {
                // Only deploy if the Docker image is built successfully
                expression { dockerImage != null }
            }
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    
                    // Deploy the Docker container
                    dockerImage.run("-d --name ${CONTAINER_NAME} -p ${PORT}")
                }
            }
        }
    }
    post {
        always {
            // Clean up unused Docker images to save space
            sh 'docker image prune -f'
        }
        failure {
            // Send a notification or take action on failure
            echo "Build failed"
        }
    }
}
