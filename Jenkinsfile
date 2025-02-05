pipeline 
{
    agent any

    tools 
    {
        maven 'Maven'
    }

    stages 
    {
        stage('Build') 
        {
            steps 
            {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') 
        {
            steps 
            {
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/demo/'
            }
        }

        stage('Push to Docker Hub') 
        {
            steps 
            {
               sh 'echo "newanusha@123" | docker login -u "anushamadalli" --password-stdin'
                sh 'docker push anushamadalli/app2'
            }
        }
    }

        stage('Remove Local Docker Image') 
    {
        {
            steps 
            {
                sh 'docker rmi -f anushamadalli/app2'
            }
        }

        stage('Run Docker Container') 
        {
            steps 
            {
                sh 'docker run -it -d --name anusha -p 8081:8080 anushamadalli/app2'
            }
        }
    }

    post 
    {
        always 
        {
            echo 'Deployment completed!'
        }
        success 
        {
            echo 'Pipeline succeeded!'
        }
        failure 
        {
            echo 'Pipeline failed!'
            sh 'docker container prune -f'
        }
    }
}