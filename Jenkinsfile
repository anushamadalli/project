pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login --username myusername --password-stdin'
                    sh 'docker tag myapp myusername/myapp:latest'
                    sh 'docker push myusername/myapp:latest'
                }
            }
        }

        stage('Remove Local Docker Image') {
            steps {
                sh 'docker rmi myusername/myapp:latest'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8081:8080 myusername/myapp:latest'
            }
        }
    }

    post {
        always {
            echo 'Deployment completed!'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
            sh 'docker container prune -f'
        }
    }
}
