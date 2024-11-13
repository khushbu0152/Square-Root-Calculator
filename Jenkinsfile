pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/username/repository.git', branch: 'main'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'pytest --junitxml=test_results.xml'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('myapp:test')
                }
            }
        }
        stage('Deploy to Docker') {
            steps {
                sh 'docker run -d --name myapp-container -p 8080:8080 myapp:test'
            }
        }
    }
}
