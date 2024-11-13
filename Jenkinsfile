pipeline {
    agent any
    environment {
        IMAGE_NAME = "myapp:test"
        CONTAINER_NAME = "myapp-container"
        PORT = "5000:5000"
        VENV_PATH = 'venv' // Path to the virtual environment
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Pull code from GitHub
                git url: 'https://github.com/khushbu0152/Square-Root-Calculator.git', branch: 'main'
            }
        }
        
        stage('Set Up Virtual Environment') {
            steps {
                script {
                    // Check if virtual environment exists; if not, create it
                    if (!fileExists("${VENV_PATH}/Scripts/activate")) {
                        bat 'python -m venv venv'
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install pytest inside the virtual environment
                bat '.\\venv\\Scripts\\activate && pip install pytest'
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    try {
                        // Run tests using pytest from the virtual environment
                        bat '.\\venv\\Scripts\\activate && pytest --junitxml=test_results.xml'
                    } catch (Exception e) {
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
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Deploy to Docker Container') {
            when {
                expression { dockerImage != null }
            }
            steps {
                script {
                    bat "docker rm -f ${CONTAINER_NAME} || echo 'No existing container found'"
                    bat "docker run -d --name ${CONTAINER_NAME} -p ${PORT} ${IMAGE_NAME}"
                }
            }
        }
    }
    post {
        always {
            bat 'docker image prune -f'
        }
        failure {
            echo "Build failed"
        }
    }
}
