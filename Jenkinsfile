pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "hub.docker.com"
        DOCKER_IMAGE_NAME = "sumaiyap/python-web"
        DOCKER_IMAGE_TAG = "v2"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Image') {
            steps {
                script {
                    def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", "-f Dockerfile .")
                }
            }
        }
        
        stage('Push Image to Registry') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", 'docker-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
			docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").run("-p 80:8080 -d --name my-container")
                    // Deploy the image, e.g., using Docker Compose or Kubernetes
                    // Example: sh 'docker-compose up -d'
                }
            }
        }
    }
    
    post {
        always {
            script {
                dockerImage.remove()
            }
        }
    }
}
