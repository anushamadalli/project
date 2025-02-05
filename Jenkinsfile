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
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/demo/'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'newanusha@123', variable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login --username anushamadalli --password-stdin'
                    sh 'docker tag app anushamadalli/app2'
                    sh 'docker push anushamadalli/app2'
                }
            }
        }

        stage('Remove Local Docker Image') {
            steps {
                sh 'docker rmi anushamadalli/app2'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8081:8080 anushamadalli/app2'
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
